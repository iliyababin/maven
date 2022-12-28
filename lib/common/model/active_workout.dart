import 'package:Maven/common/model/workout.dart';

class ActiveWorkout {
  int? activeWorkoutId;
  String name;
  int isPaused;

  ActiveWorkout({
    this.activeWorkoutId,
    required this.name,
    required this.isPaused,
  });

  factory ActiveWorkout.fromMap(Map<String, dynamic> json) => ActiveWorkout(
      activeWorkoutId: json["activeWorkoutId"],
      name:  json["name"],
    isPaused:  json["isPaused"],
  );

  static ActiveWorkout workoutToActiveWorkout(Workout workout){
    return ActiveWorkout(
      name: workout.name,
      isPaused: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activeWorkoutId': activeWorkoutId,
      'name': name,
      'isPaused': isPaused,
    };
  }
}