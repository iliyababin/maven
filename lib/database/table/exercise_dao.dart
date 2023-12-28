
import 'package:floor/floor.dart';

import 'exercise.dart';

@dao
abstract class ExerciseDao {
  @insert
  Future<int> add(Exercise exercise);

  @insert
  Future<List<int>> addAll(List<Exercise> exercises);

  @Query('SELECT * FROM exercise WHERE id = :exerciseId')
  Future<Exercise?> get(int exerciseId);

  @Query('SELECT * FROM exercise ORDER BY name ASC')
  Future<List<Exercise>> getAll();

  @update
  Future<int> modify(Exercise exercise);

  @delete
  Future<int> remove(Exercise exercise);
}