import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class SessionDataDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(SessionData workoutData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<SessionData> workoutData);

  @Query('SELECT * FROM session_data WHERE id = :sessionDataId')
  Future<SessionData?> get(int sessionDataId);

  @Query('SELECT * FROM session_data')
  Future<List<SessionData>> getAll();

  @Query('SELECT * FROM session_data WHERE routine_id = :routineId')
  Future<SessionData?> getByRoutineId(int routineId);

  @update
  Future<int> modify(SessionData workoutData);

  @delete
  Future<int> remove(SessionData workoutData);
}
