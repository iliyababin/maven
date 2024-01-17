import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../exercise.dart';

part 'exercise_group_dto.g.dart';

@CopyWith()
class ExerciseGroupDto extends BaseExerciseGroup {
  const ExerciseGroupDto({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.exerciseId,
    required super.barId,
    required super.routineId,
    this.sets = const [],
    this.notes = const [],
  });

  ExerciseGroupDto.fromBase({
    required BaseExerciseGroup baseExerciseGroup,
    this.sets = const [],
    this.notes = const [],
  }) : super(
          id: baseExerciseGroup.id,
          timer: baseExerciseGroup.timer,
          weightUnit: baseExerciseGroup.weightUnit,
          distanceUnit: baseExerciseGroup.distanceUnit,
          exerciseId: baseExerciseGroup.exerciseId,
          barId: baseExerciseGroup.barId,
          routineId: baseExerciseGroup.routineId,
        );

  final List<Note> notes;
  final List<ExerciseSetDto> sets;

  @override
  String toString() {
    return 'ExerciseGroupDto{notes: $notes, sets: $sets}';
  }
}