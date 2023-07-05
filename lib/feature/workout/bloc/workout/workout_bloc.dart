import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common.dart';
import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../model/workout.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({
    required this.routineDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.workoutDataDao,
    required this.exerciseGroupService,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_initialize);
    on<WorkoutStart>(_start);
    on<WorkoutFinish>(_finish);
    on<WorkoutDelete>(_delete);
  }

  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final WorkoutDataDao workoutDataDao;

  final ExerciseGroupService exerciseGroupService;

  Future<void> _initialize(WorkoutInitialize event, emit) async {
    Workout? workout = await _getWorkout();
    emit(state.copyWith(
      status: workout == null ? WorkoutStatus.none : WorkoutStatus.active,
      workout: workout,
    ));
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    await workoutDataDao.add(WorkoutData(
      isActive: true,
      timeElapsed: const Timed.zero(),
      routineId: await _addRoutine(event.routine, RoutineType.workout),
    ));

    emit(state.copyWith(
      status: WorkoutStatus.active,
      workout: await _getWorkout(),
    ));
  }

  Future<void> _finish(WorkoutFinish event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(
      status: WorkoutStatus.loading,
    ));

    await routineDao.remove(event.workout.routine);
    await workoutDataDao.remove(event.workout.data);

    emit(state.copyWith(
      status: WorkoutStatus.none,
    ));
  }

  Future<void> _delete(WorkoutDelete event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(
      status: WorkoutStatus.loading,
    ));

    await routineDao.remove(state.workout!.routine);
    await workoutDataDao.remove(state.workout!.data);

    emit(state.copyWith(
      status: WorkoutStatus.none,
    ));
  }

  Future<int> _addRoutine(Routine routine, RoutineType type) async {
    int routineId = await routineDao.add(Routine(
      name: routine.name,
      note: routine.note,
      timestamp: DateTime.now(),
      sort: -1,
      type: type,
    ));

    for (BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(routine.id!)) {
      int exerciseGroupId = await exerciseGroupDao.add(BaseExerciseGroup(
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: routineId,
      ));

      for (BaseNote note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
        await noteDao.add(BaseNote(
          data: note.data,
          exerciseGroupId: exerciseGroupId,
        ));
      }

      for (BaseExerciseSet exerciseSet in await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!)) {
        int exerciseSetId = await exerciseSetDao.add(BaseExerciseSet(
          type: exerciseSet.type,
          checked: exerciseSet.checked,
          exerciseGroupId: exerciseGroupId,
        ));

        for (BaseExerciseSetData exerciseSetData in await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!)) {
          await exerciseSetDataDao.add(BaseExerciseSetData(
            value: exerciseSetData.value,
            fieldType: exerciseSetData.fieldType,
            exerciseSetId: exerciseSetId,
          ));
        }
      }
    }
    return routineId;
  }

  Future<Workout?> _getWorkout() async {
    List<WorkoutData> workoutData = await workoutDataDao.getByIsActive();

    if (workoutData.isEmpty) {
      return null;
    }

    Routine? routine = await routineDao.get(workoutData.first.routineId);

    if (routine == null) {
      throw Exception('Routine was not found. wtf happened?');
    }

    return Workout(
      routine: routine,
      data: workoutData.first,
      exerciseGroups: await exerciseGroupService.getByRoutineId(routine.id!),
    );
  }
}
