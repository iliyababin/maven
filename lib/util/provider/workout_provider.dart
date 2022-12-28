import 'package:flutter/material.dart';

import '../../common/model/workout.dart';
import '../database_helper.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  WorkoutProvider() {
    init();
  }

  void init() async {
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
  }

  Future<Workout?> getWorkout(int workoutId) async {
    return await DatabaseHelper.instance.getWorkout(workoutId);
  }

  Future<int> addWorkout(Workout workout) async {
    int j = await DatabaseHelper.instance.addWorkout(workout);
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED");
    return j;
  }

  void deleteWorkout(int workoutId) async {
    DatabaseHelper.instance.deleteWorkout(workoutId);
    DatabaseHelper.instance.deleteExerciseGroupsByWorkoutId(workoutId);
    DatabaseHelper.instance.deleteExerciseSetsByWorkoutId(workoutId);
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED 2");
  }
}