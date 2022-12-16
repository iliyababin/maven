
class Workout {
  final String workoutId;
  final String name;

  const Workout({
    required this.workoutId,
    required this.name,
  });

  static Workout fromJson(json) => Workout(
      workoutId: json['workoutId'],
      name: json['name'],
  );
}