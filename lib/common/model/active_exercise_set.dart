import 'package:Maven/common/model/exercise_set.dart';

class ActiveExerciseSet {
  int? activeExerciseSetId;
  int? weight;
  int? reps;
  int activeExerciseGroupId;
  int workoutId;

  ActiveExerciseSet({
    this.activeExerciseSetId,
    this.weight,
    this.reps,
    required this.activeExerciseGroupId,
    required this.workoutId,
  });

  factory ActiveExerciseSet.fromMap(Map<String, dynamic> json) => ActiveExerciseSet(
    activeExerciseSetId: json["activeExerciseSetId"],
    weight: json["weight"],
    reps: json["reps"],
    activeExerciseGroupId: json["activeExerciseGroupId"],
    workoutId: json["workoutId"],
  );

  Map<String, dynamic> toMap() {
    return {
      'activeExerciseSetId': activeExerciseSetId,
      'weight': weight,
      'reps': reps,
      'activeExerciseGroupId': activeExerciseGroupId,
      'workoutId': workoutId,
    };
  }

  static ActiveExerciseSet exerciseSetToActiveExerciseSet(ExerciseSet exerciseSet, int activeExerciseGroupId, int workoutId) {
    return ActiveExerciseSet(
      activeExerciseGroupId: activeExerciseGroupId,
      workoutId: workoutId,
      reps: exerciseSet.reps,
      weight: exerciseSet.weight,
    );
  }
}
