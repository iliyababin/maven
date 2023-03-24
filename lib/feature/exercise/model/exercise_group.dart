import 'package:equatable/equatable.dart';

import '../../../common/model/timed.dart';
import '../../template/model/template_exercise_group.dart';
import '../../workout/model/workout_exercise_group.dart';

class ExerciseGroup extends Equatable {
  const ExerciseGroup({
    required this.exerciseGroupId,
    required this.restTimed,
    required this.exerciseId,
    required this.barId,
  });

  final int exerciseGroupId;
  final Timed restTimed;
  final int exerciseId;
  final int? barId;

  ExerciseGroup copyWith({
    int? exerciseGroupId,
    Timed? restTimed,
    int? exerciseId,
    int? barId,
  }) {
    return ExerciseGroup(
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      restTimed: restTimed ?? this.restTimed,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
    );
  }

  WorkoutExerciseGroup toWorkoutExerciseGroup(int workoutId) {
    return WorkoutExerciseGroup(
      workoutExerciseGroupId: exerciseGroupId,
      restTimed: restTimed,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }

  static ExerciseGroup from(TemplateExerciseGroup templateExerciseGroup) {
    return ExerciseGroup(
      exerciseGroupId: templateExerciseGroup.templateExerciseGroupId!,
      restTimed: templateExerciseGroup.restTimed,
      barId: templateExerciseGroup.barId,
      exerciseId: templateExerciseGroup.exerciseId,
    );
  }

  @override
  List<Object?> get props => [
    exerciseGroupId,
    restTimed,
    barId,
    exerciseId,
  ];
}