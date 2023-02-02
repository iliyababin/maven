import 'package:Maven/common/model/workout_exercise_group.dart';
import 'package:Maven/common/model/workout_exercise_set.dart';
import 'package:Maven/feature/workout/template/dao/exercise_dao.dart';
import 'package:Maven/feature/workout/template/dao/template_dao.dart';
import 'package:Maven/feature/workout/workout/dao/workout_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../template/dao/template_exercise_group_dao.dart';
import '../../../template/dao/template_exercise_set_dao.dart';
import '../../../template/model/exercise.dart';
import '../../../template/model/template.dart';
import '../../../template/model/template_exercise_group.dart';
import '../../../template/model/template_exercise_set.dart';
import '../../dao/workout_exercise_group_dao.dart';
import '../../dao/workout_exercise_set_dao.dart';
import '../../model/workout.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {

  final ExerciseDao exerciseDao;
  final TemplateDao templateDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;


  WorkoutBloc({
    required this.exerciseDao,
    required this.templateDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,

    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_workoutInitialize);
    on<WorkoutFromTemplate>(_workoutFromTemplate);
    on<WorkoutPause>(_workoutPause);
    on<WorkoutUnpause>(_workoutUnpause);
    on<WorkoutDelete>(_workoutDelete);
    on<WorkoutAddExercise>(_workoutAddExercise);
    on<WorkoutAddActiveExerciseSet>(_workoutAddActiveExerciseSet);

    on<DeleteActiveExerciseSet>((event, emit) async {
      await workoutExerciseSetDao.deleteWorkoutExerciseSet(event.activeExerciseSetId);

      List<WorkoutExerciseGroup> activeExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(state.workout!.workoutId!);

      List<WorkoutExerciseSet> activeExerciseSets = [];

      for(WorkoutExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<WorkoutExerciseSet> activeExerciseBunch = await workoutExerciseSetDao
            .getWorkoutExerciseSetsByWorkoutExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
          activeExerciseSets: () => activeExerciseSets
      ));
    });


    on<UpdateActiveExerciseSet>((event, emit) async {
      await workoutExerciseSetDao.updateWorkoutExerciseSet(event.activeExerciseSet);
    });
  }


  Future<void> _workoutInitialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();
    Workout? workout = await workoutDao.getPausedWorkout();
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
    await workoutDao.updateWorkout(workout);
    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();
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
    await workoutDao.updateWorkout(workout);
    Workout? updatedWorkout = await workoutDao.getPausedWorkout();
    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();
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
    workoutDao.deleteWorkout(workoutId);
    workoutExerciseGroupDao.deleteWorkoutExerciseGroupsByWorkoutId(workoutId);
    workoutExerciseSetDao.deleteWorkoutExerciseSetsByWorkoutId(workoutId);
    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();
    emit(state.copyWith(
      status: () => WorkoutStatus.none,
      pausedWorkouts: () => pausedWorkouts,
      activeExerciseGroups: () => [],
      activeExerciseSets: () => [],
      exercises: () => [],
    ));
  }

  Future<void> _workoutAddExercise(WorkoutAddExercise event, emit) async {
    workoutExerciseGroupDao.addWorkoutExerciseGroup(
      WorkoutExerciseGroup.exerciseToActiveExerciseGroup(
        event.exercise.exerciseId,
        state.workout!.workoutId!,
      )
    );
    List<WorkoutExerciseGroup> activeExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(state.workout!.workoutId!);
    emit(state.copyWith(
      activeExerciseGroups: () => activeExerciseGroups
    ));
  }

  Future<void> _workoutAddActiveExerciseSet(WorkoutAddActiveExerciseSet event, emit) async {
    workoutExerciseSetDao.addWorkoutExerciseSet(
      WorkoutExerciseSet(
        activeExerciseGroupId: event.activeExerciseGroupId,
        workoutId: state.workout!.workoutId!,
        weight: 0,
        reps: 0,
        checked: 0
      )
    );
    List<WorkoutExerciseGroup> activeExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(state.workout!.workoutId!);
    List<WorkoutExerciseSet> activeExerciseSets = [];
    for(WorkoutExerciseGroup activeExerciseGroup in activeExerciseGroups){
      List<WorkoutExerciseSet> activeExerciseBunch = await workoutExerciseSetDao
          .getWorkoutExerciseSetsByWorkoutExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
      activeExerciseSets.addAll(activeExerciseBunch);
    }
    emit(state.copyWith(
      activeExerciseSets: () => activeExerciseSets
    ));
  }
  
  
  
  
  Future<void> _updateWorkoutsItems(emit, {
    required Workout workout,
  }) async {
    List<WorkoutExerciseGroup> activeExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(workout.workoutId!);
    List<WorkoutExerciseSet> activeExerciseSets = [];
    List<Exercise> exercises = [];
    for(WorkoutExerciseGroup activeExerciseGroup in activeExerciseGroups){
      List<WorkoutExerciseSet> activeExerciseBunch = await workoutExerciseSetDao
          .getWorkoutExerciseSetsByWorkoutExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
      activeExerciseSets.addAll(activeExerciseBunch);
      Exercise? exercise = await exerciseDao.getExercise(activeExerciseGroup.exerciseId);
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
    Template? template = await templateDao.getTemplate(templateId);
    Workout convertedWorkout = Workout.fromTemplate(template!);
    int workoutId = await workoutDao.addWorkout(convertedWorkout);
    List<TemplateExerciseGroup> exerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(templateId);
    for (var exerciseGroup in exerciseGroups) {
      int activeExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup.exerciseToActiveExerciseGroup(exerciseGroup.exerciseId, workoutId));

      List<TemplateExerciseSet> exerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(exerciseGroup.templateExerciseGroupId!);
      for(var exerciseSet in exerciseSets){
        workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet.exerciseSetToActiveExerciseSet(exerciseSet, activeExerciseGroupId, workoutId));
      }
    }

    Workout? workout = await workoutDao.getWorkout(workoutId);
    if(workout == null) {
      throw UnimplementedError('The generated and saved workout was somehow null');
    } else {
      return workout;
    }
  }
}