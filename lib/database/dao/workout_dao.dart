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

  @Query('SELECT * FROM workout WHERE is_active = true')
  Future<Workout?> getActiveWorkout();

  @Query('SELECT * FROM workout WHERE is_active = false')
  Stream<List<Workout>> getPausedWorkoutsAsStream();

  @update
  Future<void> updateWorkout(Workout workout);

  @delete
  Future<int> deleteWorkout(Workout workout);
}