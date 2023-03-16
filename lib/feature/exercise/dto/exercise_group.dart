class ExerciseGroup {
  const ExerciseGroup({
    required this.exerciseGroupId,
    required this.exerciseId,
    required this.barId,
  });

  final int exerciseGroupId;
  final int exerciseId;
  final int? barId;

  ExerciseGroup copyWith({
    int? exerciseGroupId,
    int? exerciseId,
    int? barId,
  }) {
    return ExerciseGroup(
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
    );
  }
}