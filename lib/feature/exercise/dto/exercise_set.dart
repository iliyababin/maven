class ExerciseSet {
  ExerciseSet({
    required this.exerciseSetId,
    required this.option1,
    this.option2,
    this.checked,
    required this.exerciseGroupId,
  });

  final int exerciseSetId;
  final int option1;
  final int? option2;
  final int? checked;
  final int exerciseGroupId;

  ExerciseSet copyWith({
    int? exerciseSetId,
    int? option1,
    int? option2,
    int? checked,
    int? exerciseGroupId,
  }) {
    return ExerciseSet(
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      option1: option1 ?? this.option1,
      option2: option2 ?? this.option2,
      checked: checked ?? this.checked,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }
}