
import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ExerciseSetDataDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(BaseExerciseSetData exerciseSet);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<BaseExerciseSetData> exerciseSets);

  @Query('SELECT * FROM exercise_set WHERE id = :exerciseSetId')
  Future<BaseExerciseSetData?> get(int exerciseSetId);

  @Query('SELECT * FROM exercise_set')
  Future<List<BaseExerciseSetData>> getAll();

  @Query('SELECT * FROM exercise_set_data WHERE exercise_set_id = :exerciseSetId')
  Future<List<BaseExerciseSetData>> getByExerciseSetId(int exerciseSetId);

  @Query('SELECT sort FROM exercise_set')
  Future<List<int>> getSortOrder();

  @update
  Future<int> modify(BaseExerciseSetData exerciseSet);

  @delete
  Future<int> remove(BaseExerciseSetData exerciseSet);

}