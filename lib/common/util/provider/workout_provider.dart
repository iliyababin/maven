import 'package:Maven/common/model/workout.dart';
import 'package:flutter/material.dart';

import '../database_helper.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  WorkoutProvider() {
    init();
  }

  void init() async {
    _workouts = await DBHelper.instance.getWorkouts();
    notifyListeners();
  }

  Future<Workout?> getWorkout(int workoutId) async {
    return await DBHelper.instance.getWorkout(workoutId);
  }

  Future<int> addWorkout(Workout workout) async {
    int j = await DBHelper.instance.addWorkout(workout);
    _workouts = await DBHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED");
    return j;
  }

  void deleteWorkout(int workoutId) async {
    DBHelper.instance.deleteWorkout(workoutId);
    DBHelper.instance.deleteExerciseGroupsByWorkoutId(workoutId);
    DBHelper.instance.deleteExerciseSetsByWorkoutId(workoutId);
    _workouts = await DBHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED 2");
  }
}