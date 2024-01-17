import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../database/database.dart';
import '../exercise.dart';

part 'exercise_set_dto.g.dart';

@CopyWith()
class ExerciseSetDto extends BaseExerciseSet {
  ExerciseSetDto({
    super.id,
    required super.type,
    required super.checked,
    required super.exerciseGroupId,
    this.data = const [],
  });

  ExerciseSetDto.fromBase({
    required BaseExerciseSet baseExerciseSet,
    this.data = const [],
  }) : super(
          id: baseExerciseSet.id,
          type: baseExerciseSet.type,
          checked: baseExerciseSet.checked,
          exerciseGroupId: baseExerciseSet.exerciseGroupId,
        );

  final List<ExerciseSetDataDto> data;
}
