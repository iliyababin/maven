class ExerciseSet {
  final String exerciseSetId;
  final String weight;
  final String reps;
  final String exerciseGroupId;

  const ExerciseSet({
    required this.exerciseSetId,
    required this.weight,
    required this.reps,
    required this.exerciseGroupId,
  });

  static ExerciseSet fromJson(json) => ExerciseSet(
      exerciseSetId: json['exerciseSetId'],
      weight: json['weight'],
      reps: json['reps'],
      exerciseGroupId: json['exerciseGroupId']
  );

}