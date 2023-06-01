import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maven/feature/complete/model/complete_exercise_bundle.dart';

import '../../../../database/database.dart';
import '../../model/complete_bundle.dart';

part 'complete_exercise_event.dart';
part 'complete_exercise_state.dart';

class CompleteExerciseBloc extends Bloc<CompleteExerciseEvent, CompleteExerciseState> {
  CompleteExerciseBloc({
    required CompleteDao completeDao,
    required CompleteExerciseGroupDao completeExerciseGroupDao,
    required CompleteExerciseSetDao completeExerciseSetDao,
  })  : _completeDao = completeDao,
        _completeExerciseGroupDao = completeExerciseGroupDao,
        _completeExerciseSetDao = completeExerciseSetDao,
        super(const CompleteExerciseState()) {
    on<CompleteExerciseInitialize>(_initialize);
    on<CompleteExerciseLoad>(_load);
  }

  final CompleteDao _completeDao;
  final CompleteExerciseGroupDao _completeExerciseGroupDao;
  final CompleteExerciseSetDao _completeExerciseSetDao;

  void _initialize(CompleteExerciseInitialize event, Emitter<CompleteExerciseState> emit) {
    emit(state.copyWith(status: CompleteExerciseStatus.loading));
    emit(state.copyWith(status: CompleteExerciseStatus.loaded));
  }

  Future<void> _load(CompleteExerciseLoad event, Emitter<CompleteExerciseState> emit) async {
    emit(state.copyWith(status: CompleteExerciseStatus.loading));

    List<CompleteExerciseGroup> completeExerciseGroups = await _completeExerciseGroupDao.getCompleteExerciseGroupsByExerciseId(event.exerciseId);

    List<CompleteBundle> completeBundles = [];

    for (CompleteExerciseGroup completeExerciseGroup in completeExerciseGroups) {
      Complete? complete = await _completeDao.getComplete(completeExerciseGroup.completeId);
      if (complete == null) continue;
      List<CompleteExerciseSet> completeExerciseSets =
          await _completeExerciseSetDao.getCompleteExerciseSetsByCompleteExerciseGroupId(completeExerciseGroup.completeExerciseGroupId!);
      completeBundles.add(CompleteBundle(
        complete: complete,
        completeExerciseBundles: [
          CompleteExerciseBundle(
            completeExerciseGroup: completeExerciseGroup,
            completeExerciseSets: completeExerciseSets,
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
