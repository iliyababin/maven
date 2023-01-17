

class ActiveExerciseGroup {
  int? activeExerciseGroupId;
  final int exerciseId;
  final int workoutId;

  ActiveExerciseGroup({
    this.activeExerciseGroupId,
    required this.exerciseId,
    required this.workoutId,
  });

  factory ActiveExerciseGroup.fromMap(Map<String, dynamic> json) {
    return ActiveExerciseGroup(
      activeExerciseGroupId: json['activeExerciseGroupId'] ,
      exerciseId: json['exerciseId'],
      workoutId: json['workoutId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activeExerciseGroupId': activeExerciseGroupId,
      'exerciseId': exerciseId,
      'workoutId': workoutId,
    };
  }

  static ActiveExerciseGroup exerciseToActiveExerciseGroup(int exerciseId, int workoutId) {
    return ActiveExerciseGroup(
      exerciseId: exerciseId,
      workoutId: workoutId
    );
  }
}