
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/dao/exercise_dao.dart';
import '../../../../database/dao/template_dao.dart';
import '../../../../database/dao/template_exercise_group_dao.dart';
import '../../../../database/dao/template_exercise_set_dao.dart';
import '../../../../database/dao/workout_dao.dart';
import '../../../../database/dao/workout_exercise_group_dao.dart';
import '../../../../database/dao/workout_exercise_set_dao.dart';
import '../../../../database/model/exercise.dart';
import '../../../../database/model/template.dart';
import '../../../../database/model/template_exercise_group.dart';
import '../../../../database/model/template_exercise_set.dart';
import '../../../../database/model/workout.dart';
import '../../../../database/model/workout_exercise_group.dart';
import '../../../../database/model/workout_exercise_set.dart';
import '../../../exercise/model/exercise_group.dart';
import '../../../exercise/model/exercise_set.dart';

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

    on<WorkoutStream>(_workoutStream);
    on<WorkoutsPausedStream>(_workoutsPausedStream);
    on<WorkoutExerciseGroupStream>(_workoutExerciseGroupStream);
    on<WorkoutExerciseSetStream>(_workoutExerciseSetStream);

    on<WorkoutExerciseGroupAdd>(_workoutExerciseGroupAdd);
    on<WorkoutExerciseGroupUpdate>(_workoutExerciseGroupUpdate);

    on<WorkoutExerciseSetAdd>(_workoutExerciseSetAdd);
    on<WorkoutExerciseSetUpdate>(_workoutExerciseSetUpdate);
    on<WorkoutExerciseSetDelete>(_workoutExerciseSetDelete);


    on<WorkoutStartTemplate>(_workoutStartTemplate);
    on<WorkoutUpdate>(_workoutUpdate);
    on<WorkoutItemsUpdate>(_workoutItemsUpdate);
    
   /*on<WorkoutStartEmpty>(_workoutStartEmpty);
    on<WorkoutPause>(_workoutPause);
    on<WorkoutUnpause>(_workoutUnpause);
    on<WorkoutDelete>(_workoutDelete);*/
  }

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final ExerciseDao exerciseDao;
  final TemplateDao templateDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  Future<void> _workoutInitialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));

    workoutDao.getActiveWorkoutAsStream().listen((event) => add(WorkoutStream(workout: event)));
    workoutExerciseGroupDao.getWorkoutExerciseGroupsAsStream().listen((event) => add(WorkoutExerciseGroupStream(workoutExerciseGroups: event)));
    workoutExerciseSetDao.getWorkoutExerciseSetsAsStream().listen((event) => add(WorkoutExerciseSetStream(workoutExerciseSets: event)));

    workoutDao.getPausedWorkoutsAsStream().listen((event) => add(WorkoutsPausedStream(pausedWorkouts: event)));

    emit(state.copyWith(status: () => WorkoutStatus.loaded));
  }

  /// ------------------------------
  ///
  /// Manage workout exercise groups
  ///
  /// ------------------------------

  /// Adds a workout exercise group to repository
  Future<void> _workoutExerciseGroupAdd(WorkoutExerciseGroupAdd event, Emitter<WorkoutState> emit) async {
    await workoutExerciseGroupDao.addWorkoutExerciseGroup(event.exerciseGroup.toWorkoutExerciseGroup(state.workout!.workoutId!).copyWithNullId());
  }

  /// Updates a workout exercise group in repository
  Future<void> _workoutExerciseGroupUpdate(WorkoutExerciseGroupUpdate event, Emitter<WorkoutState> emit) async {
    await workoutExerciseGroupDao.updateWorkoutExerciseGroup(event.exerciseGroup.toWorkoutExerciseGroup(state.workout!.workoutId!));
  }

  /// ----------------------------
  ///
  /// Manage workout exercise sets
  ///
  /// ----------------------------

  /// Adds a workout exercise set to repository
  Future<void> _workoutExerciseSetAdd(WorkoutExerciseSetAdd event, Emitter<WorkoutState> emit) async {
    await workoutExerciseSetDao.addWorkoutExerciseSet(event.exerciseSet.toWorkoutExerciseSet(state.workout!.workoutId!).copyWithNullId());
  }

  /// Updates a workout exercise set in repository
  Future<void> _workoutExerciseSetUpdate(WorkoutExerciseSetUpdate event, Emitter<WorkoutState> emit) async {
    await workoutExerciseSetDao.updateWorkoutExerciseSet(event.exerciseSet.toWorkoutExerciseSet(state.workout!.workoutId!));
  }

  /// Deletes a workout exercise set in repository
  Future<void> _workoutExerciseSetDelete(WorkoutExerciseSetDelete event, Emitter<WorkoutState> emit) async {
    await workoutExerciseSetDao.deleteWorkoutExerciseSet(event.exerciseSet.toWorkoutExerciseSet(state.workout!.workoutId!));
  }

  /// -----------------------------
  ///
  /// Update the state from streams
  ///
  /// -----------------------------

  /// Updates the state with an active workout
  Future<void> _workoutStream(WorkoutStream event, emit) async {
    if(event.workout == null) {
      /// No active workout so do nothing for now...
    } else {
      emit(state.copyWith(workout: () => event.workout!));
    }
  }

  /// Updates the state with a list of paused workouts
  Future<void> _workoutsPausedStream(WorkoutsPausedStream event, emit) async {
    state.copyWith(pausedWorkouts: () => event.pausedWorkouts);
  }

  /// Updates the state with exercise groups
  Future<void> _workoutExerciseGroupStream(WorkoutExerciseGroupStream event, emit) async {
    List<Exercise> exercises = [];
    List<ExerciseGroup> exerciseGroups = [];

    List<WorkoutExerciseGroup> workoutExerciseGroups = event.workoutExerciseGroups.where((workoutExerciseGroup){
      return workoutExerciseGroup.workoutId == state.workout?.workoutId;
    }).toList();

    for(WorkoutExerciseGroup workoutExerciseGroup in workoutExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup.exerciseId);
      exercises.add(exercise!);
      exerciseGroups.add(ExerciseGroup(
        exerciseGroupId: workoutExerciseGroup.workoutExerciseGroupId!,
        restTimed: workoutExerciseGroup.restTimed,
        barId: workoutExerciseGroup.barId,
        exerciseId: exercise.exerciseId,
      ));
    }

    emit(state.copyWith(
      exercises: () => exercises,
      exerciseGroups: () => exerciseGroups,
    ));
  }

  /// Updates the state with exercise sets
  Future<void> _workoutExerciseSetStream(WorkoutExerciseSetStream event, emit) async {
    List<ExerciseSet> exerciseSets = event.workoutExerciseSets.where((workoutExerciseSet){
      return workoutExerciseSet.workoutId == state.workout?.workoutId;
    }).map((workoutExerciseSet) {
      return ExerciseSet(
        exerciseSetId: workoutExerciseSet.workoutExerciseSetId!,
        option1: workoutExerciseSet.option_1,
        option2: workoutExerciseSet.option_2,
        checked: workoutExerciseSet.checked,
        exerciseGroupId: workoutExerciseSet.workoutExerciseGroupId
      );
    }).toList();
    emit(state.copyWith(exerciseSets: () => exerciseSets));
  }

  /// --------------
  ///
  /// Manage workout
  ///
  /// --------------
  Future<void> _workoutStartTemplate(WorkoutStartTemplate event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));

    Workout convertedWorkout = Workout(
      name: event.template.name,
      isPaused: 0,
      timestamp: DateTime.now(),
    );

    int workoutId = await workoutDao.addWorkout(convertedWorkout);

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.template.templateId!);

    for (var templateExerciseGroup in templateExerciseGroups) {
      int workoutExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup(
        restTimed: templateExerciseGroup.restTimed,
        barId: templateExerciseGroup.barId,
        exerciseId: templateExerciseGroup.exerciseId,
        workoutId: workoutId,
      ));

      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.templateExerciseGroupId!);

      for(var templateExerciseSet in templateExerciseSets){
        workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
          workoutExerciseGroupId: workoutExerciseGroupId,
          workoutId: workoutId,
          option_1: templateExerciseSet.option1,
          option_2: templateExerciseSet.option2,
          checked: 0,
        ));
      }
    }

    emit(state.copyWith(status: () => WorkoutStatus.loaded));
  }

  Future<void> _workoutUpdate(WorkoutUpdate event, emit) async {
    await workoutDao.updateWorkout(event.workout);
  }

  Future<void> _workoutItemsUpdate(WorkoutItemsUpdate event, emit) async {
    for(ExerciseGroup exerciseGroup in event.exerciseGroups) {
      await workoutExerciseGroupDao.updateWorkoutExerciseGroup(exerciseGroup.toWorkoutExerciseGroup(state.workout!.workoutId!));
    }
    for(ExerciseSet exerciseSet in event.exerciseSets) {
      await workoutExerciseSetDao.updateWorkoutExerciseSet(exerciseSet.toWorkoutExerciseSet(state.workout!.workoutId!));
    }
  }

  /*Future<void> _workoutStartEmpty(WorkoutStartEmpty event, emit) async {
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
*/
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