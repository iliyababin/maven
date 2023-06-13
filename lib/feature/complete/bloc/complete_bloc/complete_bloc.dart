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
    required this.sessionDao,
    required this.exerciseDao,
    required this.completeExerciseGroupDao,
    required this.completeExerciseSetDao,
    required this.workoutDao,
  }) : super(const CompleteState()) {
    on<CompleteInitialize>(_initialize);
    on<CompleteAdd>(_add);
  }

  final SessionDao sessionDao;
  final ExerciseDao exerciseDao;
  final SessionExerciseGroupDao completeExerciseGroupDao;
  final SessionExerciseSetDao completeExerciseSetDao;
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
    int completeId = await sessionDao.addSession(Session(
      name: event.workout.name,
      description: event.workout.description,
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

      int completeExerciseGroupId = await completeExerciseGroupDao.addSessionExerciseGroup(SessionExerciseGroup(
        order: i + 1,
        exerciseId: exerciseBundle.exercise.exerciseId!,
        barId: exerciseBundle.barId,
        sessionId: completeId,
        timer: exerciseBundle.exerciseGroup.timer,
        weightUnit: exerciseBundle.exerciseGroup.weightUnit,
      ));

      for (ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
        if(exerciseSet.checked == 1) {
          await completeExerciseSetDao.addSessionExerciseSet(SessionExerciseSet(
            option1: exerciseSet.option1,
            option2: exerciseSet.option2,
            setType: exerciseSet.setType,
            sessionExerciseGroupId: completeExerciseGroupId,
            sessionId: completeId,
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
    double volume = 0;

    List<Session> completes = await sessionDao.getSessions();
    for (Session complete in completes) {
      volume = 0;
      List<CompleteExerciseBundle> completeExerciseBundles = [];

      List<SessionExerciseGroup> completeExerciseGroups = await completeExerciseGroupDao.getSessionExerciseGroupsBySessionId(complete.id!);
      for (SessionExerciseGroup completeExerciseGroup in completeExerciseGroups) {
        Exercise? exercise = await exerciseDao.getExercise(completeExerciseGroup.exerciseId);
        List<SessionExerciseSet> completeExerciseSets = await completeExerciseSetDao.getSessionExerciseSetsBySessionExerciseGroupId(completeExerciseGroup.id!);

        for(SessionExerciseSet completeExerciseSet in completeExerciseSets) {
          volume += completeExerciseSet.option1 * (completeExerciseSet.option2 ?? 0);
        }

        completeExerciseBundles.add(CompleteExerciseBundle(
          exercise: exercise!,
          completeExerciseGroup: completeExerciseGroup,
          completeExerciseSets: completeExerciseSets,
        ));
      }

      completeBundles.add(CompleteBundle(
        complete: complete,
        completeExerciseBundles: completeExerciseBundles,
        volume: volume,
      ));
    }

    return completeBundles;
  }
}
