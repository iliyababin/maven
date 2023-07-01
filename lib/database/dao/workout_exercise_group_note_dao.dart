
import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class WorkoutExerciseGroupNoteDao {
  @insert
  Future<int> add(WorkoutExerciseGroupNote workoutExerciseGroupNote);

  @Query('SELECT * FROM workout_exercise_group_note')
  Future<List<WorkoutExerciseGroupNote>> getAll();

  @Query('SELECT * FROM workout_exercise_group_note WHERE exercise_group_id = :workoutExerciseGroupId')
  Future<List<WorkoutExerciseGroupNote>> getByWorkoutExerciseGroupId(int workoutExerciseGroupId);

  @update
  Future<int> modify(WorkoutExerciseGroupNote workoutExerciseGroupNote);

  @delete
  Future<int> remove(WorkoutExerciseGroupNote workoutExerciseGroupNote);
}