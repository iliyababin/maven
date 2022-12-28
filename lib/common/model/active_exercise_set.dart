import 'package:Maven/common/model/exercise_set.dart';

class ActiveExerciseSet {
  int? activeExerciseSetId;
  int? weight;
  int? reps;
  int activeExerciseGroupId;
  int activeWorkoutId;

  ActiveExerciseSet({
    this.activeExerciseSetId,
    this.weight,
    this.reps,
    required this.activeExerciseGroupId,
    required this.activeWorkoutId,
  });

  factory ActiveExerciseSet.fromMap(Map<String, dynamic> json) => ActiveExerciseSet(
    activeExerciseSetId: json["activeExerciseSetId"],
    weight: json["weight"],
    reps: json["reps"],
    activeExerciseGroupId: json["activeExerciseGroupId"],
    activeWorkoutId: json["activeWorkoutId"],
  );

  Map<String, dynamic> toMap() {
    return {
      'activeExerciseSetId': activeExerciseSetId,
      'weight': weight,
      'reps': reps,
      'activeExerciseGroupId': activeExerciseGroupId,
      'activeWorkoutId': activeWorkoutId,
    };
  }

  static ActiveExerciseSet exerciseSetToActiveExerciseSet(ExerciseSet exerciseSet, int activeExerciseGroupId, int activeWorkoutId) {
    return ActiveExerciseSet(
      activeExerciseGroupId: activeExerciseGroupId,
      activeWorkoutId: activeWorkoutId,
      reps: exerciseSet.reps,
      weight: exerciseSet.weight,
    );
  }
}
