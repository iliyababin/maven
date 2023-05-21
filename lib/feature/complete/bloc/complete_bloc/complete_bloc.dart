import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_set.dart';
import '../../model/complete_bundle.dart';
import '../../model/complete_exercise_bundle.dart';

part 'complete_event.dart';
part 'complete_state.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  CompleteBloc({
    required this.completeDao,
    required this.exerciseDao,
    required this.completeExerciseGroupDao,
    required this.completeExerciseSetDao,
    required this.workoutDao,
  }) : super(const CompleteState()) {
    on<CompleteInitialize>(_initialize);
    on<CompleteAdd>(_add);
  }

  final CompleteDao completeDao;
  final ExerciseDao exerciseDao;
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

      int count = 0;
      for (ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
        if (exerciseSet.checked != 0) count++;
      }
      if(count == 0) continue;

      int completeExerciseGroupId = await completeExerciseGroupDao.addCompleteExerciseGroup(CompleteExerciseGroup(
        order: i + 1,
        exerciseId: exerciseBundle.exercise.exerciseId!,
        barId: exerciseBundle.barId,
        completeId: completeId,
      ));

      for (ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
        if(exerciseSet.checked == 1) {
          await completeExerciseSetDao.addCompleteExerciseSet(CompleteExerciseSet(
            option1: exerciseSet.option1,
            option2: exerciseSet.option2,
            setType: exerciseSet.setType,
            completeExerciseGroupId: completeExerciseGroupId,
            completeId: completeId,
          ));
        }
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
    for (Complete complete in completes) {
      List<CompleteExerciseBundle> completeExerciseBundles = [];

      List<CompleteExerciseGroup> completeExerciseGroups = await completeExerciseGroupDao.getCompleteExerciseGroupsByCompleteId(complete.completeId!);
      for (CompleteExerciseGroup completeExerciseGroup in completeExerciseGroups) {
        Exercise? exercise = await exerciseDao.getExercise(completeExerciseGroup.exerciseId);
        List<CompleteExerciseSet> completeExerciseSets = await completeExerciseSetDao.getCompleteExerciseSetsByCompleteExerciseGroupId(completeExerciseGroup.completeExerciseGroupId!);

        completeExerciseBundles.add(CompleteExerciseBundle(
          exercise: exercise!,
          completeExerciseGroup: completeExerciseGroup,
          completeExerciseSets: completeExerciseSets,
        ));
      }

      completeBundles.add(CompleteBundle(
        complete: complete,
        completeExerciseBundles: completeExerciseBundles,
      ));
    }

    return completeBundles;
  }
}
