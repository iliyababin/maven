
import 'package:floor/floor.dart';

import '../model/exercise_field.dart';

@dao
abstract class ExerciseFieldDao {
  @Query('SELECT * FROM exercise_field')
  Future<List<ExerciseField>> getExerciseFields();

  @Query('SELECT * FROM exercise_field WHERE id = :id')
  Future<ExerciseField?> getExerciseField(int id);

  @Query('SELECT * FROM exercise_field WHERE exercise_id = :exerciseId')
  Future<List<ExerciseField>> getExerciseFieldsByExerciseId(int exerciseId);

  @insert
  Future<int> addExerciseField(ExerciseField exerciseField);

  @insert
  Future<List<int>> addExerciseFields(List<ExerciseField> exerciseFields);

  @update
  Future<int> updateExerciseField(ExerciseField exerciseField);

  @delete
  Future<int> deleteExerciseField(ExerciseField exerciseField);
}