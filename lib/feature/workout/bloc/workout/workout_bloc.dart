import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common.dart';
import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../../note/note.dart';
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
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_initialize);
    on<WorkoutStart>(_start);
    on<WorkoutExerciseGroup>(_exerciseGroup);
  }

  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final WorkoutDataDao workoutDataDao;


  Future<void> _initialize(WorkoutInitialize event, emit) async {
    Workout? workout = await _getWorkout();
    emit(state.copyWith(
      status: workout == null ? WorkoutStatus.none : WorkoutStatus.active,
      workout: workout,
    ));
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    int workoutId = await routineDao.add(Routine(
      name: event.routine.name,
      note: event.routine.note,
      timestamp: DateTime.now(),
      sort: -1,
      type: RoutineType.workout,
    ));

    await workoutDataDao.add(WorkoutData(
      isActive: true,
      timeElapsed: const Timed.zero(),
      routineId: workoutId,
    ));

    for (BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(event.routine.id!)) {
      int exerciseGroupId = await exerciseGroupDao.add(BaseExerciseGroup(
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: workoutId,
      ));

      for(BaseNote note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
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

    emit(state.copyWith(
      status: WorkoutStatus.active,
      workout: await _getWorkout(),
    ));
  }

  Future<void> _exerciseGroup(WorkoutExerciseGroup event, Emitter<WorkoutState> emit) async {
    switch (event.action) {
      case ExerciseGroupAction.add:
        for(ExerciseGroup exerciseGroup in event.exerciseGroups) {
          exerciseGroupDao.add(exerciseGroup);
        }
        break;
      case ExerciseGroupAction.update:
        for(ExerciseGroup exerciseGroup in event.exerciseGroups) {
          exerciseGroupDao.modify(exerciseGroup);
        }
        break;
      case ExerciseGroupAction.delete:
        for(ExerciseGroup exerciseGroup in event.exerciseGroups) {
          exerciseGroupDao.remove(exerciseGroup);
        }
        break;
    }
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

    List<ExerciseGroup> exerciseGroups = [];

    for(BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(routine.id!)) {
      List<Note> notes = [];
      for (BaseNote note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
        notes.add(Note(
          id: note.id,
          data: note.data,
          exerciseGroupId: note.exerciseGroupId,
        ));
      }

      List<ExerciseSet> exerciseSets = [];
      for (BaseExerciseSet exerciseSet in await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!)) {
        List<ExerciseSetData> exerciseSetData = [];
        for(BaseExerciseSetData baseExerciseSetData in await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!)) {
          exerciseSetData.add(ExerciseSetData(
            id: baseExerciseSetData.id,
            value: baseExerciseSetData.value,
            fieldType: baseExerciseSetData.fieldType,
            exerciseSetId: baseExerciseSetData.exerciseSetId,
          ));
        }

        exerciseSets.add(ExerciseSet(
          id: exerciseSet.id,
          type: exerciseSet.type,
          checked: exerciseSet.checked,
          exerciseGroupId: exerciseSet.exerciseGroupId,
          data: exerciseSetData
        ));
      }

      exerciseGroups.add(ExerciseGroup(
        id: exerciseGroup.id,
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: exerciseGroup.routineId,
        notes: notes,
        sets: exerciseSets,
      ));
    }

    return Workout(
      routine: routine,
      workoutData: workoutData.first,
      exerciseGroups: exerciseGroups,
    );
  }
}
