class ExerciseSet {
  int? exerciseSetId;
  int? weight;
  int? reps;
  int exerciseGroupId;
  int workoutId;

  ExerciseSet({
    this.exerciseSetId,
    this.weight,
    this.reps,
    required this.exerciseGroupId,
    required this.workoutId,
  });

  factory ExerciseSet.fromMap(Map<String, dynamic> json) => ExerciseSet(
        exerciseSetId: json["exerciseSetId"],
        weight: json["weight"],
        reps: json["reps"],
        exerciseGroupId: json["exerciseGroupId"],
        workoutId: json["workoutId"],
      );

  Map<String, dynamic> toMap() {
    return {
      'exerciseSetId': exerciseSetId,
      'weight': weight,
      'reps': reps,
      'exerciseGroupId': exerciseGroupId,
      'workoutId': workoutId,
    };
  }
}
