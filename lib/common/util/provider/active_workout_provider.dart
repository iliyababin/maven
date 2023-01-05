import 'package:Maven/common/model/active_workout.dart';
import 'package:flutter/material.dart';

import '../database_helper.dart';

class ActiveWorkoutProvider with ChangeNotifier {
  List<ActiveWorkout> _activeWorkouts = [];
  List<ActiveWorkout> _pausedActiveWorkouts = [];

  List<ActiveWorkout> get activeWorkouts => _activeWorkouts;
  List<ActiveWorkout> get pausedActiveWorkouts => _pausedActiveWorkouts;

  ActiveWorkoutProvider() {
    init();
  }

  void init() async {
    _activeWorkouts = await DBHelper.instance.getActiveWorkouts();
    _pausedActiveWorkouts = await DBHelper.instance.getPausedActiveWorkouts();
    notifyListeners();
  }

  Future<int> addActiveWorkout(ActiveWorkout activeWorkout) async {
    int j = await DBHelper.instance.addActiveWorkout(activeWorkout);
    _activeWorkouts = await DBHelper.instance.getActiveWorkouts();
    notifyListeners();
    return j;
  }

  Future<int> generateActiveWorkoutTemplate(int workoutId) async {
    int activeWorkoutId = await DBHelper.instance.generateActiveWorkoutTemplate(workoutId);
    _activeWorkouts = await DBHelper.instance.getActiveWorkouts();
    notifyListeners();
    return activeWorkoutId;
  }

  Future<void> updateActiveWorkout(ActiveWorkout activeWorkout) async {
    DBHelper.instance.updateActiveWorkout(activeWorkout);
    _pausedActiveWorkouts = await DBHelper.instance.getPausedActiveWorkouts();
    notifyListeners();
  }

  Future<void> deleteActiveWorkout(int activeWorkoutId) async {
    DBHelper.instance.deleteActiveWorkout(activeWorkoutId);
    DBHelper.instance.deleteActiveExerciseGroupsByActiveWorkoutId(activeWorkoutId);
    DBHelper.instance.deleteActiveExerciseSetsByActiveWorkoutId(activeWorkoutId);
    _activeWorkouts = await DBHelper.instance.getActiveWorkouts();
    notifyListeners();
  }
}
