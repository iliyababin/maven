import 'package:Maven/common/model/exercise_set.dart';

class ActiveExerciseSet {
  int? activeExerciseSetId;
  int? weight;
  int? reps;
  int checked;
  int activeExerciseGroupId;
  int workoutId;

  ActiveExerciseSet({
    this.activeExerciseSetId,
    this.weight,
    this.reps,
    required this.checked,
    required this.activeExerciseGroupId,
    required this.workoutId,
  });

  factory ActiveExerciseSet.fromMap(Map<String, dynamic> json) => ActiveExerciseSet(
    activeExerciseSetId: json["activeExerciseSetId"],
    weight: json["weight"],
    reps: json["reps"],
    checked: json["checked"],
    activeExerciseGroupId: json["activeExerciseGroupId"],
    workoutId: json["workoutId"],
  );

  Map<String, dynamic> toMap() {
    return {
      'activeExerciseSetId': activeExerciseSetId,
      'weight': weight,
      'reps': reps,
      'checked': checked,
      'activeExerciseGroupId': activeExerciseGroupId,
      'workoutId': workoutId,
    };
  }

  static ActiveExerciseSet exerciseSetToActiveExerciseSet(ExerciseSet exerciseSet, int activeExerciseGroupId, int workoutId) {
    return ActiveExerciseSet(
      activeExerciseGroupId: activeExerciseGroupId,
      workoutId: workoutId,
      weight: exerciseSet.weight,
      reps: exerciseSet.reps,
      checked: 0,
    );
  }
}
