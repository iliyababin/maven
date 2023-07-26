import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/common.dart';
import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
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
    required this.databaseService,
    required this.sessionDataDao,
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

  Future<void> _initialize(SessionInitialize event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
    ));
  }

  Future<void> _add(SessionAdd event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    int routineId = await routineDao.add(Routine(
      id: event.workout.data.id == -1 ? event.workout.data.id : null ,
      name: event.workout.routine.name,
      note: event.workout.routine.note,
      timestamp: DateTime.now(),
      type: RoutineType.session,
    ));

    await sessionDataDao.add(SessionData(
      timeElapsed: const Timed.zero(),
      routineId: routineId,
    ));

    for(ExerciseGroup exerciseGroup in event.workout.exerciseGroups) {
      int completedSets = 0;
      for(ExerciseSet exerciseSet in exerciseGroup.sets) {
        int completedFields = 0;
        for(ExerciseSetData data in exerciseSet.data) {
          if (data.value.isEmpty) continue;
          completedSets++;
        }
        if(completedFields == 0) continue;
      }
      if(completedSets == 0) continue;

      int exerciseGroupId = await exerciseGroupDao.add(ExerciseGroup(
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: routineId,
      ));

      for(ExerciseSet exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao.add(ExerciseSet(
          type: exerciseSet.type,
          checked: true,
          exerciseGroupId: exerciseGroupId,
        ));

        for(ExerciseSetData exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(ExerciseSetData(
            value: exerciseSetData.value,
            fieldType: exerciseSetData.fieldType,
            exerciseSetId: exerciseSetId
          ));
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
        )
      ),
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

  int _sessionSortComparison(Session a, Session b) {
    final propertyA = a.routine.timestamp;
    final propertyB = a.routine.timestamp;

    int result = propertyA.compareTo(propertyB);

    if (result < 0) {
      return -1;
    } else if (result > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<void> _import(SessionImport event, Emitter<SessionState> emit) async {
    emit(state.copyWith(
      status: SessionStatus.loading,
    ));

    for(Session session in event.sessions) {
      int sessionId = await routineDao.add(session.routine);
      await sessionDataDao.add(SessionData(
        timeElapsed: session.data.timeElapsed,
        routineId: sessionId,
      ));

      for(ExerciseGroup group in session.exerciseGroups) {
        int exerciseGroupId = await exerciseGroupDao.add(group.copyWith(
          routineId: sessionId,
        ));
        /*for(ExerciseSet exerciseSet in exerciseGroup.sets) {
          int exerciseSetId = await exerciseSetDao.add(exerciseSet);
          for(ExerciseSetData exerciseSetData in exerciseSet.data) {
            await exerciseSetDataDao.add(exerciseSetData);
          }
        }*/
      }
    }

    emit(state.copyWith(
      status: SessionStatus.loaded,
      sessions: await _getSessions(),
    ));
  }
  Future<List<Session>> _getSessions({SessionSort sort = SessionSort.newest}) async {
    List<Session> sessions = [];
    for(Routine routine in await routineDao.getByType(RoutineType.session)) {
      SessionData? data = await sessionDataDao.getByRoutineId(routine.id!);
      List<ExerciseGroup> exerciseGroups =  await databaseService.getByRoutineId(routine.id!);
      sessions.add(Session(
        routine: routine,
        exerciseGroups: exerciseGroups,
        data: data!,
        volume: await databaseService.getVolume(exerciseGroups),
        musclePercentages: await databaseService.getMusclePercentages(exerciseGroups),
      ));
    }

    switch(sort) {
      case SessionSort.newest:
        sessions.sort(_sessionSortComparison);
        return sessions;
      case SessionSort.oldest:
        sessions.sort(_sessionSortComparison);
        sessions = sessions.reversed.toList();
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
