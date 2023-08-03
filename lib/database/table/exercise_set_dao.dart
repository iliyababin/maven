import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ExerciseSetDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(BaseExerciseSet exerciseSet);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<BaseExerciseSet> exerciseSets);

  @Query('SELECT * FROM exercise_set WHERE id = :exerciseSetId')
  Future<BaseExerciseSet?> get(int exerciseSetId);

  @Query('SELECT * FROM exercise_set')
  Future<List<BaseExerciseSet>> getAll();

  @Query('SELECT * FROM exercise_set WHERE exercise_group_id = :exerciseGroupId')
  Future<List<BaseExerciseSet>> getByExerciseGroupId(int exerciseGroupId);

  @Query('SELECT sort FROM exercise_set')
  Future<List<int>> getSortOrder();

  @update
  Future<int> modify(BaseExerciseSet exerciseSet);

  @delete
  Future<int> remove(BaseExerciseSet exerciseSet);

}