import 'package:Maven/common/model/template.dart';

class Workout {
  int? workoutId;
  String name;
  int isPaused;
  DateTime datetime;

  Workout({
    this.workoutId,
    required this.name,
    required this.isPaused,
    required this.datetime,
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
      workoutId: json["workoutId"],
      name: json["name"],
    isPaused: json["isPaused"],
    datetime: DateTime.parse(json["datetime"]),
  );

  static Workout templateToWorkout(Template template){
    return Workout(
      name: template.name,
      isPaused: 0,
      datetime: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'name': name,
      'isPaused': isPaused,
      'datetime': datetime.toIso8601String(),
    };
  }
}