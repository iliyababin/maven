import 'package:flutter/material.dart';

import '../../common/model/active_workout.dart';
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
    _activeWorkouts = await DatabaseHelper.instance.getActiveWorkouts();
    _pausedActiveWorkouts = await DatabaseHelper.instance.getPausedActiveWorkouts();
    notifyListeners();
  }

  Future<int> addActiveWorkout(ActiveWorkout activeWorkout) async {
    int j = await DatabaseHelper.instance.addActiveWorkout(activeWorkout);
    _activeWorkouts = await DatabaseHelper.instance.getActiveWorkouts();
    notifyListeners();
    return j;
  }

  Future<int> generateActiveWorkoutTemplate(int workoutId) async {
    int activeWorkoutId = await DatabaseHelper.instance.generateActiveWorkoutTemplate(workoutId);
    _activeWorkouts = await DatabaseHelper.instance.getActiveWorkouts();
    notifyListeners();
    return activeWorkoutId;
  }

  Future<void> updateActiveWorkout(ActiveWorkout activeWorkout) async {
    DatabaseHelper.instance.updateActiveWorkout(activeWorkout);
    _pausedActiveWorkouts = await DatabaseHelper.instance.getPausedActiveWorkouts();
    notifyListeners();
  }

  Future<void> deleteActiveWorkout(int activeWorkoutId) async {
    DatabaseHelper.instance.deleteActiveWorkout(activeWorkoutId);
    DatabaseHelper.instance.deleteActiveExerciseGroupsByActiveWorkoutId(activeWorkoutId);
    DatabaseHelper.instance.deleteActiveExerciseSetsByActiveWorkoutId(activeWorkoutId);
    _activeWorkouts = await DatabaseHelper.instance.getActiveWorkouts();
    notifyListeners();
  }
}
