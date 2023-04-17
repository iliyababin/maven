import 'package:floor/floor.dart';

import '../../../database/model/workout.dart';

@dao
abstract class WorkoutDao {

  @insert
  Future<int> addWorkout(Workout workout);

  @Query('SELECT * FROM workout WHERE workout_id = :workoutId')
  Future<Workout?> getWorkout(int workoutId);

  @Query('SELECT * FROM workout')
  Future<List<Workout>> getWorkouts();

  @Query('SELECT * FROM workout WHERE is_paused = 0')
  Stream<Workout?> getActiveWorkoutAsStream();

  @Query('SELECT * FROM workout WHERE is_paused = 1')
  Stream<List<Workout>> getPausedWorkoutsAsStream();

  @update
  Future<void> updateWorkout(Workout workout);

  @Query('DELETE * FROM workout WHERE workout_id = :workoutId')
  Future<void> deleteWorkout(int workoutId);

}