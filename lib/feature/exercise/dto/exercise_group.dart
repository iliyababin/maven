class ExerciseGroup {
  const ExerciseGroup({
    required this.exerciseGroupId,
    required this.barId,
  });

  final int exerciseGroupId;
  final int? barId;

  ExerciseGroup copyWith({
    int? exerciseGroupId,
    int? barId,
  }) {
    return ExerciseGroup(
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      barId: barId ?? this.barId,
    );
  }
}