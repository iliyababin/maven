
import '../../../../common/model/workout.dart';

abstract class WorkoutRepository {

  Future<int> addWorkout(Workout workout);

  Future<Workout?> getWorkout(int workoutId);

  Future<List<Workout>> getWorkouts();

  Future<Workout?> getPausedWorkout();

  Future<List<Workout>> getPausedWorkouts();

  Future<void> updateWorkout(Workout workout);

  Future<int> deleteWorkout(int workoutId);

}