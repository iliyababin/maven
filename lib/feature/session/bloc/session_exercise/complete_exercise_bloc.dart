import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../model/complete_bundle.dart';
import '../../model/complete_exercise_bundle.dart';

part 'complete_exercise_event.dart';
part 'complete_exercise_state.dart';

class CompleteExerciseBloc extends Bloc<CompleteExerciseEvent, CompleteExerciseState> {
  CompleteExerciseBloc({
    required SessionDao completeDao,
    required SessionExerciseGroupDao completeExerciseGroupDao,
    required SessionExerciseSetDao completeExerciseSetDao,
  })  : _sessionDao = completeDao,
        _completeExerciseGroupDao = completeExerciseGroupDao,
        _completeExerciseSetDao = completeExerciseSetDao,
        super(const CompleteExerciseState()) {
    on<CompleteExerciseInitialize>(_initialize);
    on<CompleteExerciseLoad>(_load);
  }

  final SessionDao _sessionDao;
  final SessionExerciseGroupDao _completeExerciseGroupDao;
  final SessionExerciseSetDao _completeExerciseSetDao;

  void _initialize(CompleteExerciseInitialize event, Emitter<CompleteExerciseState> emit) {
    emit(state.copyWith(status: CompleteExerciseStatus.loading));
    emit(state.copyWith(status: CompleteExerciseStatus.loaded));
  }

  Future<void> _load(CompleteExerciseLoad event, Emitter<CompleteExerciseState> emit) async {
    emit(state.copyWith(status: CompleteExerciseStatus.loading));

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
            exercise: Exercise.empty,
          ),
        ],
        volume: -1,
      ));
    }

    emit(state.copyWith(
      status: CompleteExerciseStatus.loaded,
      completeBundles: completeBundles,
    ));
  }
}
