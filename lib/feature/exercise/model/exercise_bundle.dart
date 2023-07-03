

import '../../../database/database.dart';
import 'exercise_group.dart';

class ExerciseBundle {
  ExerciseBundle({
    required this.exercise,
    required this.exerciseGroup,
    required this.exerciseSets,
    required this.barId,
  });

  Exercise exercise;
  ExerciseGroup exerciseGroup;
  List<BaseExerciseSet> exerciseSets;
  int? barId;

  ExerciseBundle copyWith({
    Exercise? exercise,
    ExerciseGroup? exerciseGroup,
    List<BaseExerciseSet>? exerciseSets,
    int? barId,
  }) {
    return ExerciseBundle(
      exercise: exercise ?? this.exercise,
      exerciseGroup: exerciseGroup ?? this.exerciseGroup,
      exerciseSets: exerciseSets != null
          ? List<BaseExerciseSet>.from(exerciseSets.map((e) => e.copyWith()))
          : List<BaseExerciseSet>.from(this.exerciseSets.map((e) => e.copyWith())),
      barId: barId ?? this.barId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseBundle &&
          runtimeType == other.runtimeType &&
          exercise == other.exercise &&
          exerciseGroup == other.exerciseGroup &&
          exerciseSets == other.exerciseSets &&
          barId == other.barId;

  @override
  int get hashCode =>
      exercise.hashCode ^
      exerciseGroup.hashCode ^
      exerciseSets.hashCode ^
      barId.hashCode;

  @override
  String toString() {
    return 'ExerciseBundle{exercise: $exercise, exerciseGroup: $exerciseGroup, exerciseSets: $exerciseSets, barId: $barId}';
  }
}

