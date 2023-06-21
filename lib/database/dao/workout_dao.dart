import 'package:floor/floor.dart';

import '../model/workout.dart';

@dao
abstract class WorkoutDao {

  @insert
  Future<int> addWorkout(Workout workout);

  @Query('SELECT * FROM workout WHERE id = :workoutId')
  Future<Workout?> getWorkout(int workoutId);

  @Query('SELECT * FROM workout')
  Future<List<Workout>> getWorkouts();

  @Query('SELECT * FROM workout WHERE active = 1')
  Future<Workout?> getActiveWorkout();

  @Query('SELECT * FROM workout WHERE active = 0')
  Future<List<Workout>> getPausedWorkouts();

  @update
  Future<int> updateWorkout(Workout workout);

  @delete
  Future<int> deleteWorkout(Workout workout);
}