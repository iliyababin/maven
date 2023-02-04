class ExerciseSet {

  final int exerciseSetId;

  final int option1;

  final int? option2;

  ExerciseSet({
    required this.exerciseSetId,
    required this.option1,
    this.option2,
  });

  ExerciseSet copyWith({
    int? exerciseSetId,
    int? option1,
    int? option2
  }) {
    return ExerciseSet(
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      option1: option1 ?? this.option1,
      option2: option2 ?? this.option2,
    );
  }
}