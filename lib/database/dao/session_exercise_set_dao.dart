
import 'package:floor/floor.dart';

import '../model/session_exercise_set.dart';

@dao
abstract class SessionExerciseSetDao {
  @insert
  Future<int> addSessionExerciseSet(SessionExerciseSet sessionExerciseSet);

  @Query('SELECT * FROM session_exercise_set')
  Future<List<SessionExerciseSet>> getSessionExerciseSets();

  @Query('SELECT * FROM session_exercise_set WHERE id = :sessionExerciseSetId')
  Future<SessionExerciseSet?> getSessionExerciseSet(int sessionExerciseSetId);

  @Query('SELECT * FROM session_exercise_set WHERE exercise_group_id = :sessionExerciseGroupId')
  Future<List<SessionExerciseSet>> getSessionExerciseSetsBySessionExerciseGroupId(int sessionExerciseGroupId);

  @Query('SELECT * FROM session_exercise_set WHERE session_id = :sessionId')
  Future<List<SessionExerciseSet>> getSessionExerciseSetsBySessionId(int sessionId);

  @update
  Future<int> updateSessionExerciseSet(SessionExerciseSet sessionExerciseSet);

  @delete
  Future<int> deleteSessionExerciseSet(SessionExerciseSet sessionExerciseSet);
}