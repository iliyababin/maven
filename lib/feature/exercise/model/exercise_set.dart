import 'package:equatable/equatable.dart';
import 'package:maven/database/TEST_ZONE/exercise_group.dart';
import 'package:maven/database/model/workout_exercise_set.dart';

import '../../../database/model/template_exercise_set.dart';
import 'set_type.dart';

class ExerciseSet extends Equatable {
  const ExerciseSet({
    required this.id,
    this.checked,
    this.type = SetType.regular,
    required this.exerciseGroupId,
    this.options = const [],
  });

  final int id;
  final bool? checked;
  final SetType type;
  final int exerciseGroupId;

  final List<ExerciseSetOption> options;

  ExerciseSet copyWith({
    int? id,
    int? option1,
    int? option2,
    bool? checked,
    SetType? type,
    int? exerciseGroupId,
    List<ExerciseSetOption>? options,
  }) {
    return ExerciseSet(
      id: id ?? this.id,
      checked: checked ?? this.checked,
      type: type ?? this.type,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      options: options ?? this.options,
    );
  }

  WorkoutExerciseSet toWorkoutExerciseSet(int workoutId) {
    return WorkoutExerciseSet(
      workoutExerciseSetId: id,
      checked: checked == true ? 1 : 0,
      setType: type,
      workoutExerciseGroupId: exerciseGroupId,
      workoutId: workoutId, option_1: -999,
    );
  }

  static ExerciseSet from(TemplateExerciseSet templateExerciseSet) {
    return ExerciseSet(
      id: templateExerciseSet.templateExerciseSetId!,
      exerciseGroupId: templateExerciseSet.templateExerciseGroupId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    checked,
    exerciseGroupId,
  ];
}