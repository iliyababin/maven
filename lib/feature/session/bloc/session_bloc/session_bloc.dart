import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../common/common.dart';
import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../../routine/routine.dart';
import '../../../transfer/transfer.dart';
import '../../../workout/workout.dart';
import '../../session.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.routineService,
  }) : super(const SessionState()) {
    on<SessionInitialize>(_initialize);
    on<SessionAdd>(_add);
    on<SessionUpdate>(_update);
    on<SessionDelete>(_delete);
    on<SessionSetSort>(_setSort);
    on<SessionImport>(_import);
  }

  final RoutineService routineService;

  Future<void> _initialize(SessionInitialize event,
      Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await routineService.getSessions(),
    ));
  }

  Future<void> _add(SessionAdd event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    Session session = await routineService.addSession(event.workout);

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: [session, ...state.sessions],
    ));
  }

  Future<void> _update(SessionUpdate event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    await routineService.deleteRoutine(event.session.routine);

    add(SessionAdd(
      workout: Workout(
        routine: event.session.routine,
        exerciseGroups: event.session.exerciseGroups,
        data: const WorkoutData(
          isActive: false,
          timeElapsed: Timed.zero(),
          routineId: -1,
        ),),
    ),);
  }

  Future<void> _delete(SessionDelete event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    await routineService.deleteRoutine(event.session.routine);

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: state.sessions.where((session) =>
      session.routine.id != event.session.routine.id).toList(),
    ));
  }

  Future<void> _setSort(SessionSetSort event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    emit(state.copyWith(
      sessions: await routineService.getSessions(sort: event.sort),
      status: SessionStatus.loaded,
      sort: event.sort,
    ));
  }

  Future<void> _import(SessionImport event, Emitter<SessionState> emit) async {
    /*emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    List<Session> sessions = [];

    try {
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
    ));*/
  }
}
