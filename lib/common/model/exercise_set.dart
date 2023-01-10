class ExerciseSet {
  int? exerciseSetId;
  int? weight;
  int? reps;
  int exerciseGroupId;
  int templateId;

  ExerciseSet({
    this.exerciseSetId,
    this.weight,
    this.reps,
    required this.exerciseGroupId,
    required this.templateId,
  });

  factory ExerciseSet.fromMap(Map<String, dynamic> json) => ExerciseSet(
        exerciseSetId: json["exerciseSetId"],
        weight: json["weight"],
        reps: json["reps"],
        exerciseGroupId: json["exerciseGroupId"],
        templateId: json["templateId"],
      );

  Map<String, dynamic> toMap() {
    return {
      'exerciseSetId': exerciseSetId,
      'weight': weight,
      'reps': reps,
      'exerciseGroupId': exerciseGroupId,
      'templateId': templateId,
    };
  }
}
