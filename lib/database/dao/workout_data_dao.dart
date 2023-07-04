import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class WorkoutDataDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(WorkoutData workoutData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<WorkoutData> workoutData);

  @Query('SELECT * FROM workout_data WHERE id = :workoutDataId')
  Future<WorkoutData?> get(int workoutDataId);

  @Query('SELECT * FROM workout_data')
  Future<List<WorkoutData>> getAll();

  @Query('SELECT * FROM workout_data WHERE routine_id = :routineId')
  Future<List<WorkoutData>> getByRoutine(int routineId);

  @Query('SELECT * FROM workout_data WHERE is_active = 1')
  Future<List<WorkoutData>> getByIsActive();

  @update
  Future<int> modify(WorkoutData workoutData);

  @delete
  Future<int> remove(WorkoutData workoutData);
}
