
import 'package:floor/floor.dart';

import 'exercise_field.dart';

@dao
abstract class ExerciseFieldDao {
  @insert
  Future<int> add(ExerciseField exerciseField);

  @insert
  Future<List<int>> addAll(List<ExerciseField> exerciseFields);

  @Query('SELECT * FROM exercise_field WHERE id = :id')
  Future<ExerciseField?> get(int id);
  
  @Query('SELECT * FROM exercise_field')
  Future<List<ExerciseField>> getAll();

  @Query('SELECT * FROM exercise_field WHERE exercise_id = :exerciseId')
  Future<List<ExerciseField>> getByExerciseId(int exerciseId);

  @update
  Future<int> updateExerciseField(ExerciseField exerciseField);

  @delete
  Future<int> deleteExerciseField(ExerciseField exerciseField);
}