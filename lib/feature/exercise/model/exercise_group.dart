import 'package:Maven/feature/workout/model/workout_exercise_group.dart';
import 'package:equatable/equatable.dart';

import '../../template/model/template_exercise_group.dart';

class ExerciseGroup extends Equatable {
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
      workoutExerciseGroupId: exerciseGroupId,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }

  static ExerciseGroup from(TemplateExerciseGroup templateExerciseGroup) {
    return ExerciseGroup(
      exerciseGroupId: templateExerciseGroup.templateExerciseGroupId!,
      exerciseId: templateExerciseGroup.exerciseId,
      barId: templateExerciseGroup.barId,
    );
  }

  @override
  List<Object?> get props => [
    exerciseGroupId,
    exerciseId,
    barId,
  ];
}