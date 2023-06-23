import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';
import '../../../exercise/model/exercise_bundle.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({
    required this.exerciseDao,
    required this.exerciseFieldDao,
    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
    required this.workoutExerciseSetDataDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.templateExerciseSetDataDao,
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
  final ExerciseFieldDao exerciseFieldDao;

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final WorkoutExerciseSetDataDao workoutExerciseSetDataDao;

  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;
  final TemplateExerciseSetDataDao templateExerciseSetDataDao;

  final SessionDao completeDao;
  final SessionExerciseGroupDao completeExerciseGroupDao;
  final SessionExerciseSetDao completeExerciseSetDao;

  Future<void> _initialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(
      status: WorkoutStatus.loading,
    ));

    Workout? workout = await workoutDao.getActiveWorkout();

    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();

    if (workout == null) {
      emit(state.copyWith(
        status: WorkoutStatus.none,
        pausedWorkouts: pausedWorkouts,
      ));
    } else {
      List<ExerciseBundle> exerciseBundles = await _fetch(workout.id!);

      emit(state.copyWith(
        status: WorkoutStatus.active,
        workout: workout,
        exerciseBundles: exerciseBundles,
        pausedWorkouts: pausedWorkouts,
      ));
    }
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    if (state.status.isActive) {
      workoutDao.deleteWorkout(state.workout!);
      emit(state.copyWith(
        status: WorkoutStatus.none,
      ));
    }

    int workoutId = await workoutDao.addWorkout(Workout(
      name: event.template.name,
      description: event.template.description,
      active: true,
      timestamp: DateTime.now(),
    ));

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.template.id!);

    for (TemplateExerciseGroup templateExerciseGroup in templateExerciseGroups) {
      int workoutExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup(
        timer: templateExerciseGroup.timer,
        barId: templateExerciseGroup.barId,
        weightUnit: templateExerciseGroup.weightUnit,
        distanceUnit: templateExerciseGroup.distanceUnit,
        exerciseId: templateExerciseGroup.exerciseId,
        workoutId: workoutId,
      ));

      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.id!);

      for (TemplateExerciseSet templateExerciseSet in templateExerciseSets) {
        int workoutExerciseSetId = await workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
          exerciseGroupId: workoutExerciseGroupId,
          workoutId: workoutId,
          checked: false,
          type: templateExerciseSet.type,
        ));

        for (ExerciseSetData templateExerciseSetData in await templateExerciseSetDataDao.getTemplateExerciseSetDataByExerciseSetId(templateExerciseSet.id!)) {
          await workoutExerciseSetDataDao.addWorkoutExerciseSetData(WorkoutExerciseSetData(
            value: templateExerciseSetData.value,
            fieldType: templateExerciseSetData.fieldType,
            exerciseSetId: workoutExerciseSetId,
          ));
        }
      }
    }

    Workout? workout = await workoutDao.getWorkout(workoutId);

    List<ExerciseBundle> exerciseBundles = await _fetch(workoutId);

    emit(state.copyWith(
      status: WorkoutStatus.active,
      workout: workout!,
      exerciseBundles: exerciseBundles,
    ));
  }

  Future<void> _finish(WorkoutFinish event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(status: WorkoutStatus.none));
  }

  Future<List<ExerciseBundle>> _fetch(int workoutId) async {
    List<ExerciseBundle> exerciseBundles = [];

    List<ExerciseGroup> workoutExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(workoutId);

    for (ExerciseGroup workoutExerciseGroup in workoutExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup.exerciseId);
      List<ExerciseField> exerciseFields = await exerciseFieldDao.getExerciseFieldsByExerciseId(workoutExerciseGroup.exerciseId);
      exercise = exercise?.copyWith(fields: exerciseFields);

      List<ExerciseSet> workoutExerciseSets = await workoutExerciseSetDao.getWorkoutExerciseSetsByWorkoutExerciseGroupId(workoutExerciseGroup.id!);
      List<ExerciseSet> test = [];

      for (ExerciseSet workoutExerciseSet in workoutExerciseSets) {
        List<ExerciseSetData> workoutExerciseSetData = await workoutExerciseSetDataDao.getWorkoutExerciseSetDataByExerciseSetId(workoutExerciseSet.id!);
        test.add(workoutExerciseSet.copyWith(data: workoutExerciseSetData));
      }

      exerciseBundles.add(ExerciseBundle(
        exercise: exercise!,
        exerciseGroup: workoutExerciseGroup,
        exerciseSets: test,
        barId: workoutExerciseGroup.barId,
      ));
    }
    return exerciseBundles;
  }

  Future<void> _exerciseAdd(WorkoutExerciseAdd event, Emitter<WorkoutState> emit) async {
    if (event.exerciseGroups != null) {
      for (var exerciseGroup in event.exerciseGroups!) {
        await workoutExerciseGroupDao.addWorkoutExerciseGroup(toWorkoutExerciseGroup(exerciseGroup, state.workout!.id!));
      }
    }

    if (event.exerciseSets != null) {
      for (var exerciseSet in event.exerciseSets!) {
        await workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
          id: exerciseSet.id,
          type: exerciseSet.type,
          checked: exerciseSet.checked,
          exerciseGroupId: exerciseSet.exerciseGroupId,
          workoutId: state.workout!.id!,
        ));

        for (var exerciseSetData in exerciseSet.data!) {
          await workoutExerciseSetDataDao.addWorkoutExerciseSetData(WorkoutExerciseSetData(
            value: exerciseSetData.value,
            fieldType: exerciseSetData.fieldType,
            exerciseSetId: exerciseSet.id!,
          ));
        }
      }
    }
  }

  Future<void> _update(WorkoutUpdate event, Emitter<WorkoutState> emit) async {
    await workoutDao.updateWorkout(event.workout);
    emit(state.copyWith(
      workout: event.workout,
    ));
  }

  Future<void> _toggle(WorkoutToggle event, Emitter<WorkoutState> emit) async {
    if (state.status.isActive && event.workout.active) {
      await workoutDao.deleteWorkout(event.workout);
    }

    await workoutDao.updateWorkout(event.workout);

    List<Workout> pausedWorkouts = await workoutDao.getPausedWorkouts();

    if (event.workout.active) {
      List<ExerciseBundle> exerciseBundles = await _fetch(event.workout.id!);
      emit(state.copyWith(
        status: WorkoutStatus.active,
        workout: event.workout,
        pausedWorkouts: pausedWorkouts,
        exerciseBundles: exerciseBundles,
      ));
    } else {
      emit(state.copyWith(
        status: WorkoutStatus.none,
        pausedWorkouts: pausedWorkouts,
      ));
    }
  }

  Future<void> _delete(WorkoutDelete event, Emitter<WorkoutState> emit) async {
    await workoutDao.deleteWorkout(event.workout);

    emit(state.copyWith(
      status: WorkoutStatus.none,
      exerciseBundles: [],
    ));
  }

  Future<void> _exerciseUpdate(WorkoutExerciseUpdate event, Emitter<WorkoutState> emit) async {
    if (event.exerciseGroup != null) {
      await workoutExerciseGroupDao.updateWorkoutExerciseGroup(toWorkoutExerciseGroup(event.exerciseGroup!, state.workout!.id!));
    }

    if (event.exerciseSet != null) {
      await workoutExerciseSetDao.updateWorkoutExerciseSet(
        WorkoutExerciseSet(
          id: event.exerciseSet!.id,
          type: event.exerciseSet!.type,
          checked: event.exerciseSet!.checked,
          exerciseGroupId: event.exerciseSet!.exerciseGroupId,
          workoutId: state.workout!.id!,
        ),
      );

      for (var exerciseSetData in event.exerciseSet!.data) {
        await workoutExerciseSetDataDao.updateWorkoutExerciseSetData(WorkoutExerciseSetData(
          id: exerciseSetData.id,
          value: exerciseSetData.value,
          fieldType: exerciseSetData.fieldType,
          exerciseSetId: event.exerciseSet!.id!,
        ));
      }
    }
  }

  Future<void> _exerciseDelete(WorkoutExerciseDelete event, Emitter<WorkoutState> emit) async {
    if (event.exerciseGroup != null) {
      await workoutExerciseGroupDao.deleteWorkoutExerciseGroup(toWorkoutExerciseGroup(event.exerciseGroup!, state.workout!.id!));
    }

    if (event.exerciseSet != null) {
      await workoutExerciseSetDao.deleteWorkoutExerciseSet(
        WorkoutExerciseSet(
          id: event.exerciseSet!.id,
          type: event.exerciseSet!.type,
          checked: event.exerciseSet!.checked,
          exerciseGroupId: event.exerciseSet!.exerciseGroupId,
          workoutId: state.workout!.id!,
        ),
      );
    }
  }
}

WorkoutExerciseGroup toWorkoutExerciseGroup(ExerciseGroup exerciseGroup, int workoutId) {
  return WorkoutExerciseGroup(
    id: exerciseGroup.id,
    timer: exerciseGroup.timer,
    weightUnit: exerciseGroup.weightUnit,
    distanceUnit: exerciseGroup.distanceUnit,
    barId: exerciseGroup.barId,
    exerciseId: exerciseGroup.exerciseId,
    workoutId: workoutId,
  );
}
