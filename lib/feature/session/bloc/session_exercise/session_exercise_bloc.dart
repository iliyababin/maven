/*
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';
import '../../session.dart';

part 'session_exercise_event.dart';
part 'session_exercise_state.dart';

class SessionExerciseBloc extends Bloc<SessionExerciseEvent, SessionExerciseState> {
  SessionExerciseBloc({
    required SessionDao completeDao,
    required SessionExerciseGroupDao completeExerciseGroupDao,
    required SessionExerciseSetDao completeExerciseSetDao,
  })  : _sessionDao = completeDao,
        _completeExerciseGroupDao = completeExerciseGroupDao,
        _completeExerciseSetDao = completeExerciseSetDao,
        super(const SessionExerciseState()) {
    on<SessionExerciseInitialize>(_initialize);
    on<SessionExerciseLoad>(_load);
  }

  final SessionDao _sessionDao;
  final SessionExerciseGroupDao _completeExerciseGroupDao;
  final SessionExerciseSetDao _completeExerciseSetDao;

  void _initialize(SessionExerciseInitialize event, Emitter<SessionExerciseState> emit) {
    emit(state.copyWith(status: SessionExerciseStatus.loading));
    emit(state.copyWith(status: SessionExerciseStatus.loaded));
  }

  Future<void> _load(SessionExerciseLoad event, Emitter<SessionExerciseState> emit) async {
    emit(state.copyWith(status: SessionExerciseStatus.loading));

    List<SessionExerciseGroup> completeExerciseGroups = await _completeExerciseGroupDao.getSessionExerciseGroupsByExerciseId(event.exerciseId);

    List<SessionBundle> completeBundles = [];

    for (SessionExerciseGroup completeExerciseGroup in completeExerciseGroups) {
      Session? complete = await _sessionDao.getSession(completeExerciseGroup.sessionId);
      if (complete == null) continue;
      List<SessionExerciseSet> completeExerciseSets =
          await _completeExerciseSetDao.getSessionExerciseSetsBySessionExerciseGroupId(completeExerciseGroup.id!);
      completeBundles.add(SessionBundle(
        session: complete,
        sessionExerciseBundles: [
          SessionExerciseBundle(
            sessionExerciseGroup: completeExerciseGroup,
            sessionExerciseSets: completeExerciseSets,
            exercise: Exercise.empty(),
          ),
        ],
        volume: -1,
      ));
    }

    emit(state.copyWith(
      status: SessionExerciseStatus.loaded,
      sessionBundles: completeBundles,
    ));
  }
}
*/
