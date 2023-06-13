
import 'package:floor/floor.dart';

import '../model/session_exercise_group.dart';

@dao
abstract class SessionExerciseGroupDao {
  @insert
  Future<int> addSessionExerciseGroup(SessionExerciseGroup sessionExerciseGroup);

  @Query('SELECT * FROM session_exercise_group')
  Future<List<SessionExerciseGroup>> getSessionExerciseGroups();

  @Query('SELECT * FROM session_exercise_group WHERE id = :sessionExerciseGroupId')
  Future<SessionExerciseGroup?> getSessionExerciseGroup(int sessionExerciseGroupId);

  @Query('SELECT * FROM session_exercise_group WHERE session_id = :sessionId')
  Future<List<SessionExerciseGroup>> getSessionExerciseGroupsBySessionId(int sessionId);

  @Query('SELECT * FROM session_exercise_group WHERE exercise_id = :exerciseId')
  Future<List<SessionExerciseGroup>> getSessionExerciseGroupsByExerciseId(int exerciseId);

  @update
  Future<int> updateSessionExerciseGroup(SessionExerciseGroup sessionExerciseGroup);

  @delete
  Future<int> deleteSessionExerciseGroup(SessionExerciseGroup sessionExerciseGroup);
}