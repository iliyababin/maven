class ExerciseGroup {
  int? exerciseGroupId;
  final int exerciseId;
  final int workoutId;

  ExerciseGroup({
    this.exerciseGroupId,
    required this.exerciseId,
    required this.workoutId,
  });

  factory ExerciseGroup.fromMap(Map<String, dynamic> json) {
    return ExerciseGroup(
      exerciseGroupId: json['exerciseGroupId'] ,
      exerciseId: json['exerciseId'],
      workoutId: json['workoutId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseGroupId': exerciseGroupId,
      'exerciseId': exerciseId,
      'workoutId': workoutId,
    };
  }
}