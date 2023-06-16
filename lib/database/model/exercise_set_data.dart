import 'package:floor/floor.dart';

import '../database.dart';

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
