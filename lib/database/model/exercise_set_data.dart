import 'package:floor/floor.dart';
import 'package:maven/common/common.dart';

import '../database.dart';

@Entity(
  tableName: 'exercise_set_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_set_id'],
      parentColumns: ['id'],
      entity: BaseExerciseSet,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class BaseExerciseSetData {
  BaseExerciseSetData({
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

  double get valueAsDouble {
    if(value.isEmpty) return 0.0;
    switch (fieldType) {
      case ExerciseFieldType.reps:
        return double.parse(value);
      case ExerciseFieldType.weight:
        return double.parse(value);
      case ExerciseFieldType.duration:
        return double.parse(value);
      case ExerciseFieldType.distance:
        return double.parse(value);
      case ExerciseFieldType.bodyWeight:
        return double.parse(value);
      case ExerciseFieldType.weighted:
        return double.parse(value);
      case ExerciseFieldType.assisted:
        return double.parse(value);
    }
  }

  BaseExerciseSetData copyWith({
    int? id,
    String? value,
    ExerciseFieldType? fieldType,
    int? exerciseSetId,
  }) {
    return BaseExerciseSetData(
      id: id ?? this.id,
      value: value ?? this.value,
      fieldType: fieldType ?? this.fieldType,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    );
  }

  String stringify(BaseExerciseGroup exerciseGroup) {
    switch (fieldType) {
      case ExerciseFieldType.reps:
        return value;
      case ExerciseFieldType.weight:
        return value.truncateZeros + exerciseGroup.weightUnit!.name;
      case ExerciseFieldType.duration:
        return '$value seconds';
      case ExerciseFieldType.distance:
        return '$value ${exerciseGroup.distanceUnit!.name}';
      case ExerciseFieldType.bodyWeight:
        return '$value BODYWEIGHT';
      case ExerciseFieldType.weighted:
        return '$value bpm';
      case ExerciseFieldType.assisted:
        return '$value m/s';
    }
  }

  @override
  String toString() {
    return 'ExerciseSetData{id: $id, value: $value, fieldType: $fieldType, exerciseSetId: $exerciseSetId}';
  }
}
