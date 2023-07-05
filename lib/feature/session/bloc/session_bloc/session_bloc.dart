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
    required this.exerciseGroupService,
    required this.sessionDataDao,
  }) : super(const SessionState()) {
    on<SessionInitialize>(_initialize);
    on<SessionAdd>(_add);
  }

  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final SessionDataDao sessionDataDao;

  final ExerciseGroupService exerciseGroupService;

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
      name: event.workout.routine.name,
      note: event.workout.routine.note,
      timestamp: DateTime.now(),
      sort: -1,
      type: RoutineType.session,
    ));

    await sessionDataDao.add(SessionData(
      timeElapsed: const Timed.zero(),
      routineId: routineId,
    ));

    for(ExerciseGroup exerciseGroup in event.workout.exerciseGroups) {
      int completedSets = 0;
      for(ExerciseSet exerciseSet in exerciseGroup.sets) {
        if (exerciseSet.checked) {
          completedSets++;
        }
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
        if (!exerciseSet.checked) continue;

        int exerciseSetId = await exerciseSetDao.add(ExerciseSet(
          type: exerciseSet.type,
          checked: exerciseSet.checked,
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

  Future<List<Session>> _getSessions() async {
    List<Session> sessions = [];
    for(Routine routine in await routineDao.getByType(RoutineType.session)) {
      SessionData? data = await sessionDataDao.getByRoutineId(routine.id!);
      List<ExerciseGroup> exerciseGroups =  await exerciseGroupService.getByRoutineId(routine.id!);
      sessions.add(Session(
        routine: routine,
        exerciseGroups: exerciseGroups,
        data: data!,
        volume: exerciseGroupService.getVolume(exerciseGroups),
      ));
    }
    return sessions;
  }
}
