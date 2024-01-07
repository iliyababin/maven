import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../common/common.dart';
import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../../transfer/transfer.dart';
import '../../../workout/workout.dart';
import '../../session.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.routineDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.sessionDataDao,
    required this.databaseService,
    required this.transferService,
    required this.importDao,
  }) : super(const SessionState()) {
    on<SessionInitialize>(_initialize);
    on<SessionAdd>(_add);
    on<SessionUpdate>(_update);
    on<SessionDelete>(_delete);
    on<SessionSetSort>(_setSort);
    on<SessionImport>(_import);
  }

  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final SessionDataDao sessionDataDao;
  final DatabaseService databaseService;
  final TransferService transferService;
  final ImportDao importDao;

  Future<void> _initialize(SessionInitialize event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
      imports: await importDao.getAll(),
    ));
  }

  Future<void> _add(SessionAdd event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    int routineId = await routineDao.add(Routine(
      id: event.workout.data.id == -1 ? event.workout.data.id : null,
      name: event.workout.routine.name,
      note: event.workout.routine.note,
      timestamp: DateTime.now(),
      type: RoutineType.session,
    ));

    await sessionDataDao.add(SessionData(
      timeElapsed: const Timed.zero(),
      routineId: routineId,
    ));

    for (ExerciseGroupDto exerciseGroup in event.workout.exerciseGroups) {
      int completedSets = 0;
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int completedFields = 0;
        for (ExerciseSetDataDto data in exerciseSet.data) {
          if (data.value.isEmpty) continue;
          completedSets++;
        }
        if (completedFields == 0) continue;
      }
      if (completedSets == 0) continue;

      int exerciseGroupId = await exerciseGroupDao.add(ExerciseGroupDto(
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: routineId,
      ));

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao.add(ExerciseSetDto(
          type: exerciseSet.type,
          checked: true,
          exerciseGroupId: exerciseGroupId,
        ));

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(ExerciseSetDataDto(
              value: exerciseSetData.value,
              fieldType: exerciseSetData.fieldType,
              exerciseSetId: exerciseSetId));
        }
      }
    }

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
    ));
  }

  Future<void> _update(SessionUpdate event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    await routineDao.remove(event.session.routine);

    add(SessionAdd(
      workout: Workout(
          routine: event.session.routine,
          exerciseGroups: event.session.exerciseGroups,
          data: const WorkoutData(
            isActive: false,
            timeElapsed: Timed.zero(),
            routineId: -1,
          )),
    ));
  }

  Future<void> _delete(SessionDelete event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    await routineDao.remove(event.session.routine);

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
    ));
  }

  Future<void> _setSort(SessionSetSort event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    emit(state.copyWith(
      sessions: await _getSessions(sort: event.sort),
      status: SessionStatus.loaded,
      sort: event.sort,
    ));
  }

  Future<void> _import(SessionImport event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    List<Session> sessions = [];

    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Import Data',
      );
      if (result == null) throw Exception('No file selected');
      String fileData = await File(result.files.single.path!).readAsString();
      sessions = transferService.parse(fileData, event.source);
    } catch (e) {
      emit(state.copyWith(
        status: SessionStatus.loaded,
        message: e.toString(),
      ));
      return;
    }

    int importId = await importDao.add(Import(
      timestamp: DateTime.now(),
      source: event.source,
    ));

    for (Session session in sessions) {
      int sessionId = await routineDao.add(session.routine);
      await sessionDataDao.add(SessionData(
        timeElapsed: session.data.timeElapsed,
        routineId: sessionId,
        importId: importId,
      ));

      for (ExerciseGroupDto group in session.exerciseGroups) {
        int exerciseGroupId = await exerciseGroupDao.add(group.copyWith(
          routineId: sessionId,
        ));

        for (ExerciseSetDto set in group.sets) {
          int exerciseSetId = await exerciseSetDao.add(set.copyWith(
            exerciseGroupId: exerciseGroupId,
          ));

          for (ExerciseSetDataDto data in set.data) {
            await exerciseSetDataDao.add(data.copyWith(
              exerciseSetId: exerciseSetId,
            ));
          }
        }
      }
    }

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
      imports: await importDao.getAll(),
    ));
  }

  Future<List<Session>> _getSessions({SessionSort sort = SessionSort.newest}) async {
    List<Session> sessions = [];
    for (Routine routine in await routineDao.getByType(RoutineType.session)) {
      SessionData? data = await sessionDataDao.getByRoutineId(routine.id!);
      List<ExerciseGroupDto> exerciseGroups = await databaseService.getByRoutineId(routine.id!);
      sessions.add(Session(
        routine: routine,
        exerciseGroups: exerciseGroups,
        data: data!,
        volume: await databaseService.getVolume(exerciseGroups),
        musclePercentages: await databaseService.getMusclePercentages(exerciseGroups),
      ));
    }

    switch (sort) {
      case SessionSort.newest:
        sessions.sort((a, b) => a.routine.timestamp.compareTo(b.routine.timestamp));
        return sessions.reversed.toList();
      case SessionSort.oldest:
        sessions.sort((a, b) => a.routine.timestamp.compareTo(b.routine.timestamp));
        return sessions;
      case SessionSort.volume:
        sessions.sort((a, b) {
          final propertyA = a.volume;
          final propertyB = b.volume;
          int result = propertyA.compareTo(propertyB);
          if (result < 0) {
            return 1;
          } else if (result > 0) {
            return -1;
          } else {
            return 0;
          }
        });
        return sessions;
    }
  }
}
