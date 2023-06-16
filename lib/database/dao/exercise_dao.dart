
import 'package:floor/floor.dart';

import '../model/exercise.dart';

@dao
abstract class ExerciseDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addExercises(List<Exercise> exercises);

  @Query('SELECT * FROM exercise WHERE id = :exerciseId')
  Future<Exercise?> getExercise(int exerciseId);

  @Query('SELECT * FROM exercise')
  Future<List<Exercise>> getExercises();

  @Query('SELECT * FROM exercise')
  Stream<List<Exercise>> getExercisesAsStream();

  @update
  Future<int> updateExercise(Exercise exercise);
}