class Workout {
  int? workoutId;
  String name;

  Workout({
    this.workoutId,
    required this.name,
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
    workoutId: json["workoutId"],
    name:  json["name"]
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'name': name
    };
  }

  @override
  String toString() {
    return 'Workout{workoutId: $workoutId, name: $name}';
  }
}