class ExerciseGroup {
  final String exerciseGroupId;
  final String exerciseId;
  final String workoutId;

  const ExerciseGroup({
    required this.exerciseGroupId,
    required this.exerciseId,
    required this.workoutId,
  });

  static ExerciseGroup fromJson(json) => ExerciseGroup(
    exerciseGroupId: json['exerciseGroupId'],
    exerciseId: json['exerciseId'],
    workoutId: json['workoutId'],
  );
}