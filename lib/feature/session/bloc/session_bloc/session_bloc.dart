import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../session.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.sessionDao,
    required this.exerciseDao,
    required this.sessionExerciseGroupDao,
    required this.sessionExerciseSetDao,
    required this.sessionExerciseSetDataDao,
    required this.workoutDao,
  }) : super(const SessionState()) {
    on<SessionInitialize>(_initialize);
    on<SessionAdd>(_add);
  }

  final SessionDao sessionDao;
  final ExerciseDao exerciseDao;
  final SessionExerciseGroupDao sessionExerciseGroupDao;
  final SessionExerciseSetDao sessionExerciseSetDao;
  final SessionExerciseSetDataDao sessionExerciseSetDataDao;
  final WorkoutDao workoutDao;

  Future<void> _initialize(SessionInitialize event, Emitter<SessionState> emit) async {
    emit(state.copyWith(status: () => CompleteStatus.loading));

    List<SessionBundle> completeBundles = await _fetchSessionBundles();

    emit(state.copyWith(
      status: () => CompleteStatus.loaded,
      completeBundles: () => completeBundles,
    ));
  }

  Future<void> _add(SessionAdd event, Emitter<SessionState> emit) async {
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
        if (exerciseSet.checked) count++;
      }
      if(count == 0) continue;

      int completeExerciseGroupId = await sessionExerciseGroupDao.addSessionExerciseGroup(SessionExerciseGroup(
        order: i + 1,
        exerciseId: exerciseBundle.exercise.id!,
        barId: exerciseBundle.barId,
        sessionId: completeId,
        timer: exerciseBundle.exerciseGroup.timer,
        weightUnit: exerciseBundle.exerciseGroup.weightUnit,
        distanceUnit: exerciseBundle.exerciseGroup.distanceUnit,
      ));
      print(completeExerciseGroupId);

      for (ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
        if(exerciseSet.checked) {
          int sessionExerciseSetId = await sessionExerciseSetDao.addSessionExerciseSet(SessionExerciseSet(
            sessionId: completeId,
            exerciseGroupId: completeExerciseGroupId,
            type: exerciseSet.type,
            checked: exerciseSet.checked,
          ));

          for (ExerciseSetData exerciseSetData in exerciseSet.data) {
            await sessionExerciseSetDataDao.addSessionExerciseSetData(SessionExerciseSetData(
              exerciseSetId: sessionExerciseSetId,
              value: exerciseSetData.value,
              fieldType: exerciseSetData.fieldType,
            ));
          }
        }
      }
    }

    await workoutDao.deleteWorkout(event.workout);

    List<SessionBundle> completeBundles = await _fetchSessionBundles();

    emit(state.copyWith(
      status: () => CompleteStatus.loaded,
      completeBundles: () => completeBundles,
    ));
  }

  Future<List<SessionBundle>> _fetchSessionBundles() async {
    List<SessionBundle> sessionBundles = [];

    for (Session session in await sessionDao.getSessions()) {
      List<SessionExerciseBundle> sessionExerciseBundles = [];

      for(SessionExerciseGroup sessionExerciseGroup in await sessionExerciseGroupDao.getSessionExerciseGroupsBySessionId(session.id!)){
        List<SessionExerciseSet> sessionExerciseSets = [];
        Exercise? exercise = await exerciseDao.getExercise(sessionExerciseGroup.exerciseId!);

        for(SessionExerciseSet sessionExerciseSet in await sessionExerciseSetDao.getSessionExerciseSetsBySessionExerciseGroupId(sessionExerciseGroup.id!)){
          List<SessionExerciseSetData> sessionExerciseSetData = await sessionExerciseSetDataDao.getSessionExerciseSetDataByExerciseSetId(sessionExerciseSet.id!);
          SessionExerciseSet sessionExerciseSet2 = sessionExerciseSet.copyWith(data: sessionExerciseSetData);
          sessionExerciseSets.add(sessionExerciseSet2);
        }

        sessionExerciseBundles.add(SessionExerciseBundle(
          exercise: exercise!,
          sessionExerciseGroup: sessionExerciseGroup,
          sessionExerciseSets: sessionExerciseSets,
        ));
      }

      sessionBundles.add(SessionBundle(
        session: session,
        sessionExerciseBundles: sessionExerciseBundles,
        volume: -1,
      ));
    }

    return sessionBundles;
  }
}
