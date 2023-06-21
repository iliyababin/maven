import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class SessionExerciseSetDataDao {
  @insert
  Future<int> addSessionExerciseSetData(SessionExerciseSetData sessionExerciseSetData);

  @Query('SELECT * FROM session_exercise_set_data')
  Future<List<SessionExerciseSetData>> getSessionExerciseSetData();

  @Query('SELECT * FROM session_exercise_set_data WHERE exercise_set_id = :exerciseSetId')
  Future<List<SessionExerciseSetData>> getSessionExerciseSetDataByExerciseSetId(int exerciseSetId);

  @update
  Future<int> updateSessionExerciseSetData(SessionExerciseSetData sessionExerciseSetData);

  @delete
  Future<int> deleteSessionExerciseSetData(SessionExerciseSetData sessionExerciseSetData);
}