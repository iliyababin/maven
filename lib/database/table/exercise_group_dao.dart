
import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ExerciseGroupDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(BaseExerciseGroup exerciseGroup);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<BaseExerciseGroup> exerciseGroups);

  @Query('SELECT * FROM exercise_group WHERE id = :exerciseGroupId')
  Future<BaseExerciseGroup?> get(int exerciseGroupId);

  @Query('SELECT * FROM exercise_group')
  Future<List<BaseExerciseGroup>> getAll();

  @Query('SELECT * FROM exercise_group WHERE routine_id = :routineId')
  Future<List<BaseExerciseGroup>> getByRoutineId(int routineId);

  @Query('SELECT sort FROM exercise_group')
  Future<List<int>> getSortOrder();

  @update
  Future<int> modify(BaseExerciseGroup exerciseGroup);

  @delete
  Future<int> remove(BaseExerciseGroup exerciseGroup);
}