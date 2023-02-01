
import 'package:floor/floor.dart';

import '../../feature/workout/template/model/exercise.dart';

@dao
abstract class ExerciseDao {

  @insert
  Future<void> addExercises(List<Exercise> exercises);

  @Query('SELECT * FROM exercise WHERE exercise_id = :exerciseId')
  Future<Exercise?> getExercise(int exerciseId);

  @Query('SELECT * FROM exercise')
  Future<List<Exercise>> getExercises();

}