import 'dart:async';
import 'dart:developer';

import 'package:maven/model/workout.dart';
import 'package:maven/util/database_helper.dart';

class WorkoutBloc {

  WorkoutBloc(){
    getWorkouts();
  }

  final _workoutController = StreamController<List<Workout>>.broadcast();
  get workouts => _workoutController.stream;

  dispose(){
    _workoutController.close();
  }

  void addWorkout(Workout workout){
    DatabaseHelper.instance.addWorkout(workout);
    getWorkouts();
  }

  void deleteWorkout(int workoutId){
    DatabaseHelper.instance.deleteWorkout(workoutId);
    getWorkouts();
  }

  void updateWorkout(Workout workout){
    DatabaseHelper.instance.updateWorkout(workout);
    getWorkouts();
  }

  Future<Workout?> getWorkout(int workoutId) async {
    return DatabaseHelper.instance.getWorkout(workoutId);
  }

  void getWorkouts() async {
    _workoutController.sink.add(await DatabaseHelper.instance.getWorkouts());
  }
}