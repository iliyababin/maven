import 'package:floor/floor.dart';

import '../database.dart';
import 'exercise_field.dart';


class ExerciseSetData {
  ExerciseSetData({
    this.id,
    required this.value,
    required this.fieldType,
    required this.exerciseSetId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'value')
  String value;

  @ColumnInfo(name: 'field_type')
  ExerciseFieldType fieldType;

  @ColumnInfo(name: 'exercise_set_id')
  int exerciseSetId;

  ExerciseSetData copyWith({
    int? id,
    String? value,
    ExerciseFieldType? fieldType,
    int? exerciseSetId,
  }) {
    return ExerciseSetData(
      id: id ?? this.id,
      value: value ?? this.value,
      fieldType: fieldType ?? this.fieldType,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    );
  }
}

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