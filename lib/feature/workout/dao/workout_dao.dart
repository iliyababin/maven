import 'package:floor/floor.dart';

import '../model/workout.dart';

@dao
abstract class WorkoutDao {

  @insert
  Future<int> addWorkout(Workout workout);

  @Query('SELECT * FROM workout WHERE workout_id = :workoutId')
  Future<Workout?> getWorkout(int workoutId);

  @Query('SELECT * FROM workout')
  Future<List<Workout>> getWorkouts();

  @Query('SELECT * FROM workout WHERE is_paused = 0')
  Future<Workout?> getPausedWorkout();

  @Query('SELECT * FROM workout WHERE is_paused = 1')
  Future<List<Workout>> getPausedWorkouts();

  @update
  Future<void> updateWorkout(Workout workout);

  @Query('DELETE * FROM workout WHERE workout_id = :workoutId')
  Future<void> deleteWorkout(int workoutId);

}