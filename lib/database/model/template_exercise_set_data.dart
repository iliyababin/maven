import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'template_exercise_set_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_set_id'],
      parentColumns: ['id'],
      entity: TemplateExerciseSet,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateExerciseSetData extends ExerciseSetData {
  TemplateExerciseSetData({
    required super.value,
    required super.fieldType,
    required super.exerciseSetId
  });
}