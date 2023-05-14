import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_set.dart';
import '../../model/complete_bundle.dart';

part 'complete_event.dart';
part 'complete_state.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  CompleteBloc({
    required this.completeDao,
    required this.completeExerciseGroupDao,
    required this.completeExerciseSetDao,
    required this.workoutDao,
  }) : super(const CompleteState()) {
    on<CompleteInitialize>(_initialize);
    on<CompleteAdd>(_add);
  }

  final CompleteDao completeDao;
  final CompleteExerciseGroupDao completeExerciseGroupDao;
  final CompleteExerciseSetDao completeExerciseSetDao;
  final WorkoutDao workoutDao;

  Future<void> _initialize(CompleteInitialize event, Emitter<CompleteState> emit) async {
    emit(state.copyWith(status: () => CompleteStatus.loading));

    List<CompleteBundle> completeBundles = await _fetchCompleteBundles();

    emit(state.copyWith(
      status: () => CompleteStatus.loaded,
      completeBundles: () => completeBundles,
    ));
  }

  Future<void> _add(CompleteAdd event, Emitter<CompleteState> emit) async {
    int completeId = await completeDao.addComplete(Complete(
      name: event.workout.name,
      duration: DateTime.now().difference(event.workout.timestamp),
      timestamp: DateTime.now(),
    ));

    for (int i = 0; i < event.exerciseBundles.length; i++) {
      ExerciseBundle exerciseBundle = event.exerciseBundles[i];
      int completeExerciseGroupId = await completeExerciseGroupDao.addCompleteExerciseGroup(CompleteExerciseGroup(
        order: i + 1,
        exerciseId: exerciseBundle.exercise.exerciseId!,
        barId: exerciseBundle.barId,
        completeId: completeId,
      ));

      for (ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
        await completeExerciseSetDao.addCompleteExerciseSet(CompleteExerciseSet(
          option1: exerciseSet.option1,
          option2: exerciseSet.option2,
          setType: exerciseSet.setType,
          completeExerciseGroupId: completeExerciseGroupId,
          completeId: completeId,
        ));
      }
    }

    await workoutDao.deleteWorkout(event.workout);

    List<CompleteBundle> completeBundles = await _fetchCompleteBundles();

    emit(state.copyWith(
      status: () => CompleteStatus.loaded,
      completeBundles: () => completeBundles,
    ));
  }

  Future<List<CompleteBundle>> _fetchCompleteBundles() async {
    List<CompleteBundle> completeBundles = [];

    List<Complete> completes = await completeDao.getCompletes();
    print(completes.length);
    for (Complete complete in completes) {
      List<CompleteExerciseGroup> completeExerciseGroups = await completeExerciseGroupDao.getCompleteExerciseGroupsByCompleteId(complete.completeId!);
      List<CompleteExerciseSet> completeExerciseSets = [];

      for (CompleteExerciseGroup completeExerciseGroup in completeExerciseGroups) {
        completeExerciseSets = await completeExerciseSetDao.getCompleteExerciseSetsByCompleteExerciseGroupId(completeExerciseGroup.completeExerciseGroupId!);
      }

      completeBundles.add(CompleteBundle(
        complete: complete,
        completeExerciseGroups: completeExerciseGroups,
        completeExerciseSets: completeExerciseSets,
      ));
    }

    return completeBundles;
  }
}
