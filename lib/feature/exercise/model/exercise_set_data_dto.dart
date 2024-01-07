import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../database/database.dart';

part 'exercise_set_data_dto.g.dart';

@CopyWith()
class ExerciseSetDataDto extends BaseExerciseSetData {
  ExerciseSetDataDto({
    super.id,
    required super.value,
    required super.fieldType,
    required super.exerciseSetId,
  });
}
