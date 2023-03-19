import 'package:Maven/feature/workout/model/workout_exercise_group.dart';

class ExerciseGroup {
  const ExerciseGroup({
    required this.exerciseGroupId,
    required this.exerciseId,
    required this.barId,
  });

  final int exerciseGroupId;
  final int exerciseId;
  final int? barId;

  ExerciseGroup copyWith({
    int? exerciseGroupId,
    int? exerciseId,
    int? barId,
  }) {
    return ExerciseGroup(
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
    );
  }

  WorkoutExerciseGroup toWorkoutExerciseGroup(int workoutId) {
    return WorkoutExerciseGroup(
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }
}