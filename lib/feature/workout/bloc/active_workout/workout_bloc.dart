
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../template/dao/exercise_dao.dart';
import '../../../template/dao/template_dao.dart';
import '../../../template/dao/template_exercise_group_dao.dart';
import '../../../template/dao/template_exercise_set_dao.dart';
import '../../../template/model/template.dart';
import '../../../template/model/template_exercise_group.dart';
import '../../../template/model/template_exercise_set.dart';
import '../../dao/workout_dao.dart';
import '../../dao/workout_exercise_group_dao.dart';
import '../../dao/workout_exercise_set_dao.dart';
import '../../model/workout.dart';
import '../../model/workout_exercise_group.dart';
import '../../model/workout_exercise_set.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
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
    on<WorkoutStartTemplate>(_workoutStartTemplate);
    on<WorkoutStartEmpty>(_workoutStartEmpty);
    on<WorkoutPause>(_workoutPause);
    on<WorkoutUnpause>(_workoutUnpause);
    on<WorkoutDelete>(_workoutDelete);
  }

  final ExerciseDao exerciseDao;
  final TemplateDao templateDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;



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
      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        workout: () => workout,
        pausedWorkouts: () => pausedWorkouts,
      ));
    }
  }

  Future<void> _workoutStartTemplate(WorkoutStartTemplate event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));

    Template? template = await templateDao.getTemplate(event.template.templateId!);
    Workout convertedWorkout = Workout.fromTemplate(template!);
    int workoutId = await workoutDao.addWorkout(convertedWorkout);
    List<TemplateExerciseGroup> exerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.template.templateId!);
    for (var exerciseGroup in exerciseGroups) {
      int activeExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup.exerciseToActiveExerciseGroup(exerciseGroup.exerciseId, workoutId));

      List<TemplateExerciseSet> exerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(exerciseGroup.templateExerciseGroupId!);
      for(var exerciseSet in exerciseSets){
        workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet.exerciseSetToWorkoutExerciseSet(exerciseSet, activeExerciseGroupId, workoutId));
      }
    }

    emit(state.copyWith(status: () => WorkoutStatus.active,));
  }

  Future<void> _workoutStartEmpty(WorkoutStartEmpty event, emit) async {
    await workoutDao.addWorkout(
      Workout(
        name: 'Untitled Workout',
        isPaused: 0,
        timestamp: DateTime.now(),
      ),
    );

    Workout? pausedWorkout = await workoutDao.getPausedWorkout();

    if(pausedWorkout == null) {
      throw UnsupportedError('Could not create an empty workout. Maybe it was created but could not be found?');
    } else {
      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        workout: () => pausedWorkout,
      ));
    }
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
    ));
  }

  Future<void> _workoutUnpause(WorkoutUnpause event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));
    Workout workout = event.workout;
    workout.isPaused = 0;
    await workoutDao.updateWorkout(workout);
    Workout? updatedWorkout = await workoutDao.getPausedWorkout();
    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();
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
    ));
  }

  /*Future<void> _workoutAddExercise(WorkoutAddExercise event, emit) async {
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

  Future<void> _workoutAddWorkoutExerciseSet(WorkoutAddWorkoutExerciseSet event, emit) async {
    workoutExerciseSetDao.addWorkoutExerciseSet(
      WorkoutExerciseSet(
        workoutExerciseGroupId: event.workoutExerciseGroupId,
        workoutId: state.workout!.workoutId!,
        option_1: 0,
        option_2: 0,
        checked: 0
      )
    );
  }

  Future<void> _workoutUpdateWorkoutExerciseSet (WorkoutUpdateWorkoutExerciseSet event, emit) async {
    preventUpdates = true;
    workoutExerciseSetDao.updateWorkoutExerciseSet(event.workoutExerciseSet);
  }

  Future<void> _workoutDeleteWorkoutExerciseSet (WorkoutDeleteWorkoutExerciseSet event, emit) async {
    workoutExerciseSetDao.deleteWorkoutExerciseSet(event.workoutExerciseSet);
  }
  
  Future<void> _updateWorkoutsItems(emit, {
    required Workout workout,
  }) async {
    List<WorkoutExerciseGroup> activeExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(workout.workoutId!);
    List<WorkoutExerciseSet> activeExerciseSets = [];
    List<Exercise> exercises = [];
    for(WorkoutExerciseGroup activeExerciseGroup in activeExerciseGroups){
      List<WorkoutExerciseSet> activeExerciseBunch = await workoutExerciseSetDao
          .getWorkoutExerciseSetsByWorkoutExerciseGroupId(activeExerciseGroup.workoutExerciseGroupId!);
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
  }*/
}