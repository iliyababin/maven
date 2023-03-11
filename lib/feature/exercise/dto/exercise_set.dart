class ExerciseSet {
  ExerciseSet({
    required this.exerciseSetId,
    required this.option1,
    this.option2,
    this.barId,
    this.checked,
  });

  final int exerciseSetId;
  final int option1;
  final int? option2;
  final int? barId;
  final int? checked;

  ExerciseSet copyWith({
    int? exerciseSetId,
    int? option1,
    int? option2,
    int? barId,
    int? checked,
  }) {
    return ExerciseSet(
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      option1: option1 ?? this.option1,
      option2: option2 ?? this.option2,
      barId: barId ?? this.barId,
      checked: checked ?? this.checked,
    );
  }
}