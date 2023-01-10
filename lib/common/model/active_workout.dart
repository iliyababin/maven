import 'package:Maven/common/model/template.dart';

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

  static ActiveWorkout templateToActiveWorkout(Template template){
    return ActiveWorkout(
      name: template.name,
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