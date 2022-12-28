import 'package:Maven/common/model/exercise_group.dart';

class ActiveExerciseGroup {
  int? activeExerciseGroupId;
  final int exerciseId;
  final int activeWorkoutId;

  ActiveExerciseGroup({
    this.activeExerciseGroupId,
    required this.exerciseId,
    required this.activeWorkoutId,
  });

  factory ActiveExerciseGroup.fromMap(Map<String, dynamic> json) {
    return ActiveExerciseGroup(
      activeExerciseGroupId: json['activeExerciseGroupId'] ,
      exerciseId: json['exerciseId'],
      activeWorkoutId: json['activeWorkoutId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activeExerciseGroupId': activeExerciseGroupId,
      'exerciseId': exerciseId,
      'activeWorkoutId': activeWorkoutId,
    };
  }

  static ActiveExerciseGroup exerciseGroupToActiveExerciseGroup(ExerciseGroup exerciseGroup, int activeWorkoutId) {
    return ActiveExerciseGroup(
      exerciseId: exerciseGroup.exerciseId,
      activeWorkoutId: activeWorkoutId
    );
  }
}