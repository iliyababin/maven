
import 'package:floor/floor.dart';

import '../model/exercise.dart';

@dao
abstract class ExerciseDao {
  @insert
  Future<int> add(Exercise exercise);

  @insert
  Future<List<int>> addAll(List<Exercise> exercises);

  @Query('SELECT * FROM exercise WHERE id = :exerciseId')
  Future<Exercise?> getExercise(int exerciseId);

  @Query('SELECT * FROM exercise ORDER BY name ASC')
  Future<List<Exercise>> getExercises();

  @Query('SELECT * FROM exercise')
  Stream<List<Exercise>> getExercisesAsStream();

  @update
  Future<int> updateExercise(Exercise exercise);

  @delete
  Future<int> remove(Exercise exercise);
}