import 'package:equatable/equatable.dart';
import 'package:maven/database/TEST_ZONE/exercise_group.dart';
import 'package:maven/database/model/workout_exercise_set.dart';

import '../../../database/model/template_exercise_set.dart';
import 'set_type.dart';

class ExerciseSet extends Equatable {
  const ExerciseSet({
    required this.id,
    required this.option1,
    this.option2,
    this.checked,
    this.type = SetType.regular,
    required this.exerciseGroupId,
    this.options = const [
      RepsOption(
        id: 1,
        exerciseSetId: 1,
        reps: 10,
      ),
    ],
  });

  final int id;
  final int option1;
  final int? option2;
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
  }) {
    return ExerciseSet(
      id: id ?? this.id,
      option1: option1 ?? this.option1,
      option2: option2 ?? this.option2,
      checked: checked ?? this.checked,
      type: type ?? this.type,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }

  WorkoutExerciseSet toWorkoutExerciseSet(int workoutId) {
    return WorkoutExerciseSet(
      workoutExerciseSetId: id,
      option_1: option1,
      option_2: option2,
      checked: checked == true ? 1 : 0,
      setType: type,
      workoutExerciseGroupId: exerciseGroupId,
      workoutId: workoutId,
    );
  }

  static ExerciseSet from(TemplateExerciseSet templateExerciseSet) {
    return ExerciseSet(
      id: templateExerciseSet.templateExerciseSetId!,
      exerciseGroupId: templateExerciseSet.templateExerciseGroupId,
      option1: templateExerciseSet.option1,
      option2: templateExerciseSet.option2,
    );
  }

  @override
  List<Object?> get props => [
    id,
    option1,
    option2,
    checked,
    exerciseGroupId,
  ];
}