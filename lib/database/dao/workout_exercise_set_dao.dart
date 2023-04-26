import 'package:floor/floor.dart';

import '../model/workout_exercise_set.dart';

@dao
abstract class WorkoutExerciseSetDao {
  @insert
  Future<int> addWorkoutExerciseSet(WorkoutExerciseSet workoutExerciseSet);

  @Query('SELECT * FROM workout_exercise_set WHERE workout_exercise_set_id = :workoutExerciseSetId')
  Future<WorkoutExerciseSet?> getWorkoutExerciseSet(int workoutExerciseSetId);

  @Query('SELECT * FROM workout_exercise_set')
  Future<List<WorkoutExerciseSet>> getWorkoutExerciseSets();

  @Query('SELECT * FROM workout_exercise_set WHERE workout_exercise_group_id = :workoutExerciseGroupId')
  Future<List<WorkoutExerciseSet>> getWorkoutExerciseSetsByWorkoutExerciseGroupId(int workoutExerciseGroupId);

  @Query('SELECT * FROM workout_exercise_set')
  Stream<List<WorkoutExerciseSet>> getWorkoutExerciseSetsAsStream();

  @update
  Future<void> updateWorkoutExerciseSet(WorkoutExerciseSet workoutExerciseSet);

  @delete
  Future<void> deleteWorkoutExerciseSet(WorkoutExerciseSet workoutExerciseSet);

  // TODO: Floor doesn't update streams with @Query, waiting for update
  @Query('DELETE FROM workout_exercise_set WHERE workout_id = :workoutId')
  Future<void> deleteWorkoutExerciseSetsByWorkoutId(int workoutId);

}