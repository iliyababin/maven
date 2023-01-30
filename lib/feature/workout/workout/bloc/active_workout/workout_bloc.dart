
import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/workout/repository/active_exercise_group_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/model/exercise.dart';
import '../../../../../common/model/exercise_group.dart';
import '../../../../../common/model/exercise_set.dart';
import '../../../../../common/model/template.dart';
import '../../../../../common/model/workout.dart';
import '../../../template/repository/template_repository.dart';
import '../../repository/active_exercise_set_repository.dart';
import '../../repository/workout_repository.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {

  final WorkoutRepository workoutRepository;
  final TemplateRepository templateRepository;
  final ActiveExerciseGroupRepository activeExerciseGroupRepository;
  final ActiveExerciseSetRepository activeExerciseSetRepository;


  WorkoutBloc({
    required this.workoutRepository,
    required this.templateRepository,
    required this.activeExerciseGroupRepository,
    required this.activeExerciseSetRepository,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_workoutInitialize);
    on<WorkoutFromTemplate>(_workoutFromTemplate);
    on<WorkoutPause>(_workoutPause);
    on<WorkoutUnpause>(_workoutUnpause);
    on<WorkoutDelete>(_workoutDelete);
    on<WorkoutAddExercise>(_workoutAddExercise);
    on<WorkoutAddActiveExerciseSet>(_workoutAddActiveExerciseSet);

    on<DeleteActiveExerciseSet>((event, emit) async {
      await activeExerciseSetRepository.deleteActiveExerciseSet(event.activeExerciseSetId);

      List<ActiveExerciseGroup> activeExerciseGroups = await activeExerciseGroupRepository.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);

      List<ActiveExerciseSet> activeExerciseSets = [];

      for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<ActiveExerciseSet> activeExerciseBunch = await activeExerciseSetRepository
            .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
          activeExerciseSets: () => activeExerciseSets
      ));
    });


    on<UpdateActiveExerciseSet>((event, emit) async {
      await activeExerciseSetRepository.updateActiveExerciseSet(event.activeExerciseSet);
    });
  }


  Future<void> _workoutInitialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();
    Workout? workout = await workoutRepository.getPausedWorkout();
    if(workout == null) {
      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts,
      ));
    } else {
      await _updateWorkoutsItems(emit, workout: workout);
      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        pausedWorkouts: () => pausedWorkouts,
      ));
    }
  }

  Future<void> _workoutFromTemplate(WorkoutFromTemplate event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    Workout workout = await _generateWorkoutFromTemplate(event.template.templateId!);
    await _updateWorkoutsItems(emit, workout: workout);
    emit(state.copyWith(status: () => WorkoutStatus.active,));
  }

  Future<void> _workoutPause(WorkoutPause event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    if(state.workout == null) throw UnsupportedError('There is no workout to pause');
    Workout workout = state.workout!;
    workout.isPaused = 1;
    await workoutRepository.updateWorkout(workout);
    List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();
    emit(state.copyWith(
      status: () => WorkoutStatus.none,
      pausedWorkouts: () => pausedWorkouts,
      activeExerciseGroups: () => [],
      activeExerciseSets: () => [],
      exercises: () => [],
    ));
  }

  Future<void> _workoutUnpause(WorkoutUnpause event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    Workout workout = event.workout;
    workout.isPaused = 0;
    await workoutRepository.updateWorkout(workout);
    Workout? updatedWorkout = await workoutRepository.getPausedWorkout();
    List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();
    await _updateWorkoutsItems(emit, workout: updatedWorkout!);
    emit(state.copyWith(
      status: () => WorkoutStatus.active,
      pausedWorkouts: () => pausedWorkouts,
    ));
  }

  Future<void> _workoutDelete(WorkoutDelete event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    if(state.workout == null) throw UnsupportedError('There is no workout to pause');
    int workoutId = state.workout!.workoutId!;
    workoutRepository.deleteWorkout(workoutId);
    activeExerciseGroupRepository.deleteActiveExerciseGroupsByWorkoutId(workoutId);
    activeExerciseSetRepository.deleteActiveExerciseSetsByWorkoutId(workoutId);
    List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();
    emit(state.copyWith(
      status: () => WorkoutStatus.none,
      pausedWorkouts: () => pausedWorkouts,
      activeExerciseGroups: () => [],
      activeExerciseSets: () => [],
      exercises: () => [],
    ));
  }

  Future<void> _workoutAddExercise(WorkoutAddExercise event, emit) async {
    activeExerciseGroupRepository.addActiveExerciseGroup(
      ActiveExerciseGroup.exerciseToActiveExerciseGroup(
        event.exercise.exerciseId,
        state.workout!.workoutId!,
      )
    );
    List<ActiveExerciseGroup> activeExerciseGroups = await activeExerciseGroupRepository.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);
    emit(state.copyWith(
      activeExerciseGroups: () => activeExerciseGroups
    ));
  }

  Future<void> _workoutAddActiveExerciseSet(WorkoutAddActiveExerciseSet event, emit) async {
    activeExerciseSetRepository.addActiveExerciseSet(
      ActiveExerciseSet(
        activeExerciseGroupId: event.activeExerciseGroupId,
        workoutId: state.workout!.workoutId!,
        weight: 0,
        reps: 0,
        checked: 0
      )
    );
    List<ActiveExerciseGroup> activeExerciseGroups = await activeExerciseGroupRepository.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);
    List<ActiveExerciseSet> activeExerciseSets = [];
    for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
      List<ActiveExerciseSet> activeExerciseBunch = await activeExerciseSetRepository
          .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
      activeExerciseSets.addAll(activeExerciseBunch);
    }
    emit(state.copyWith(
      activeExerciseSets: () => activeExerciseSets
    ));
  }
  
  
  
  
  Future<void> _updateWorkoutsItems(emit, {
    required Workout workout,
  }) async {
    List<ActiveExerciseGroup> activeExerciseGroups = await activeExerciseGroupRepository.getActiveExerciseGroupsByWorkoutId(workout.workoutId!);
    List<ActiveExerciseSet> activeExerciseSets = [];
    List<Exercise> exercises = [];
    for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
      List<ActiveExerciseSet> activeExerciseBunch = await activeExerciseSetRepository
          .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
      activeExerciseSets.addAll(activeExerciseBunch);
      Exercise? exercise = await DBHelper.instance.getExercise(activeExerciseGroup.exerciseId);
      exercises.add(exercise!);
    }
    emit(state.copyWith(
      workout: () => workout,
      activeExerciseGroups: () => activeExerciseGroups,
      activeExerciseSets: () => activeExerciseSets,
      exercises: () => exercises,
    ));
  }

  Future<Workout> _generateWorkoutFromTemplate(templateId) async {
    Template? template = await templateRepository.getTemplate(templateId);
    Workout convertedWorkout = Workout.fromTemplate(template!);
    int workoutId = await workoutRepository.addWorkout(convertedWorkout);
    List<ExerciseGroup> exerciseGroups = await DBHelper.instance.getExerciseGroupsByTemplateId(templateId);
    for (var exerciseGroup in exerciseGroups) {
      int activeExerciseGroupId = await activeExerciseGroupRepository.addActiveExerciseGroup(ActiveExerciseGroup.exerciseToActiveExerciseGroup(exerciseGroup.exerciseId, workoutId));

      List<ExerciseSet> exerciseSets = await DBHelper.instance.getExerciseSetsByExerciseGroupId(exerciseGroup.exerciseGroupId!);
      for(var exerciseSet in exerciseSets){
        activeExerciseSetRepository.addActiveExerciseSet(ActiveExerciseSet.exerciseSetToActiveExerciseSet(exerciseSet, activeExerciseGroupId, workoutId));
      }
    }

    Workout? workout = await workoutRepository.getWorkout(workoutId);
    if(workout == null) {
      throw UnimplementedError('The generated and saved workout was somehow null');
    } else {
      return workout;
    }
  }
}