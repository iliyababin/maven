import '../../../common/model/workout.dart';

abstract class WorkoutRepository {

  Future<int> addWorkout(Workout workout);

  Future<Workout?> getWorkout(int workoutId);

  Future<Workout?> getWorkoutAAA();

  Future<List<Workout>> getWorkouts();

  Future<List<Workout>> getPausedWorkouts();

  Future<void> updateWorkout(Workout workout);

  Future<int> deleteWorkout(int workoutId);

}