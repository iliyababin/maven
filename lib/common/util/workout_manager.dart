import 'package:Maven/common/model/active_workout.dart';
import 'package:Maven/common/util/provider/active_workout_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'database_helper.dart';
import 'i_shared_preferences.dart';

Future<void> generateActiveWorkoutTemplate(BuildContext context, int workoutId) async {
  int test = await Provider.of<ActiveWorkoutProvider>(context, listen: false).generateActiveWorkoutTemplate(workoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", test);
}

void deleteCurrentWorkout(BuildContext context) {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  Provider.of<ActiveWorkoutProvider>(context, listen: false).deleteActiveWorkout(currentWorkoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

Future<void> pauseCurrentWorkout(BuildContext context) async {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  ActiveWorkout? activeWorkout =  await DatabaseHelper.instance.getActiveWorkout(currentWorkoutId);
  activeWorkout?.isPaused = 1;
  Provider.of<ActiveWorkoutProvider>(context, listen: false).updateActiveWorkout(activeWorkout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

void unpauseWorkout(BuildContext context, int activeWorkoutId) async {
  ActiveWorkout? activeWorkout =  await DatabaseHelper.instance.getActiveWorkout(activeWorkoutId);
  activeWorkout?.isPaused = 0;
  Provider.of<ActiveWorkoutProvider>(context, listen: false).updateActiveWorkout(activeWorkout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", activeWorkoutId);
}