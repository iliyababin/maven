
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_group.dart';
import '../../../exercise/model/exercise_set.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({
    required this.exerciseDao,
    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.completeDao,
    required this.completeExerciseGroupDao,
    required this.completeExerciseSetDao,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_initialize);
    on<WorkoutStart>(_start);
    on<WorkoutFinish>(_finish);
    on<WorkoutUpdate>(_update);
    on<WorkoutToggle>(_toggle);
    on<WorkoutDelete>(_delete);

    on<WorkoutExerciseAdd>(_exerciseAdd);
    on<WorkoutExerciseUpdate>(_exerciseUpdate);
    on<WorkoutExerciseDelete>(_exerciseDelete);
  }

  final ExerciseDao exerciseDao;
  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;
  final CompleteDao completeDao;
  final CompleteExerciseGroupDao completeExerciseGroupDao;
  final CompleteExerciseSetDao completeExerciseSetDao;

  Future<void> _initialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(
        status: () => WorkoutStatus.loading),
    );

    Workout? workout = await workoutDao.getActiveWorkout();

    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();

    if(workout == null) {
      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts,
      ));
    } else {
      List<ExerciseBundle> exerciseBundles = await _fetch(workout.workoutId!);

      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        workout: () => workout,
        exerciseBundles: () => exerciseBundles,
        pausedWorkouts: () => pausedWorkouts,
      ));
    }
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    if(state.status.isActive) {
      workoutDao.deleteWorkout(state.workout!);
      emit(state.copyWith(status: () => WorkoutStatus.none));
    }

    int workoutId = await workoutDao.addWorkout(Workout(
      name: event.template.name,
      isActive: true,
      timestamp: DateTime.now(),
    ));

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.template.id!);

    for (var templateExerciseGroup in templateExerciseGroups) {
      int workoutExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup(
        restTimed: templateExerciseGroup.restTimed,
        barId: templateExerciseGroup.barId,
        exerciseId: templateExerciseGroup.exerciseId,
        workoutId: workoutId,
      ));

      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.templateExerciseGroupId!);

      for(var templateExerciseSet in templateExerciseSets){
        int t = await workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
          workoutExerciseGroupId: workoutExerciseGroupId,
          workoutId: workoutId,
          option_1: templateExerciseSet.option1,
          option_2: templateExerciseSet.option2,
          checked: 0,
          setType: templateExerciseSet.setType,
        ));
      }
    }

    Workout? workout = await workoutDao.getWorkout(workoutId);

    List<ExerciseBundle> exerciseBundles = await _fetch(workoutId);

    emit(state.copyWith(
      status: () => WorkoutStatus.active,
      workout: () => workout!,
      exerciseBundles: () => exerciseBundles,
    ));
  }

  Future<void> _finish(WorkoutFinish event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.none));
  }

  Future<List<ExerciseBundle>> _fetch(int workoutId) async {
    List<ExerciseBundle> exerciseBundles = [];

    List<WorkoutExerciseGroup> workoutExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(workoutId);

    for(WorkoutExerciseGroup workoutExerciseGroup in workoutExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup.exerciseId);
      List<WorkoutExerciseSet> workoutExerciseSets = await workoutExerciseSetDao.getWorkoutExerciseSetsByWorkoutExerciseGroupId(workoutExerciseGroup.workoutExerciseGroupId!);

      exerciseBundles.add(ExerciseBundle(
          exercise: exercise!,
          exerciseGroup: workoutExerciseGroup.toExerciseGroup(),
          exerciseSets: workoutExerciseSets.map((workoutExerciseSet) => workoutExerciseSet.toExerciseSet()).toList(),
          barId: workoutExerciseGroup.barId
      ));
    }
    return exerciseBundles;
  }

  Future<void> _exerciseAdd(WorkoutExerciseAdd event, Emitter<WorkoutState> emit) async {
    if(event.exerciseGroups != null) {
      for(var exerciseGroup in event.exerciseGroups!) {
        await workoutExerciseGroupDao.addWorkoutExerciseGroup(exerciseGroup.toWorkoutExerciseGroup(state.workout!.workoutId!));
      }
    }

    if(event.exerciseSets != null) {
      for(var exerciseSet in event.exerciseSets!) {
        await workoutExerciseSetDao.addWorkoutExerciseSet(exerciseSet.toWorkoutExerciseSet(state.workout!.workoutId!));
      }
    }
  }
  
  Future<void> _update(WorkoutUpdate event, Emitter<WorkoutState> emit) async {
    await workoutDao.updateWorkout(event.workout);
    emit(state.copyWith(
      workout: () => event.workout,
    ));
  }

  Future<void> _toggle(WorkoutToggle event, Emitter<WorkoutState> emit) async {
    if(state.status.isActive && event.workout.isActive) {
      await workoutDao.deleteWorkout(event.workout);
    }

    await workoutDao.updateWorkout(event.workout);

    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();

    if(event.workout.isActive) {
      List<ExerciseBundle> exerciseBundles = await _fetch(event.workout.workoutId!);
      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        workout: () => event.workout,
        pausedWorkouts: () => pausedWorkouts,
        exerciseBundles: () => exerciseBundles,
      ));
    } else {
      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts,
      ));
    }
  }

  Future<void> _delete(WorkoutDelete event, Emitter<WorkoutState> emit) async {
    await workoutDao.deleteWorkout(event.workout);

    emit(state.copyWith(status: () => WorkoutStatus.none,));
  }

  Future<void> _exerciseUpdate(WorkoutExerciseUpdate event, Emitter<WorkoutState> emit) async {
    if(event.exerciseGroup != null) {
      await workoutExerciseGroupDao.updateWorkoutExerciseGroup(
        event.exerciseGroup!.toWorkoutExerciseGroup(state.workout!.workoutId!),
      );
    }

    if(event.exerciseSet != null) {
      await workoutExerciseSetDao.updateWorkoutExerciseSet(
        event.exerciseSet!.toWorkoutExerciseSet(state.workout!.workoutId!),
      );
    }
  }

  Future<void> _exerciseDelete(WorkoutExerciseDelete event, Emitter<WorkoutState> emit) async {
    if(event.exerciseGroup != null) {
      await workoutExerciseGroupDao.deleteWorkoutExerciseGroup(
        event.exerciseGroup!.toWorkoutExerciseGroup(state.workout!.workoutId!),
      );
    }

    if(event.exerciseSet != null) {
      await workoutExerciseSetDao.deleteWorkoutExerciseSet(
        event.exerciseSet!.toWorkoutExerciseSet(state.workout!.workoutId!),
      );
    }
  }
}