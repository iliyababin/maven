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

  String get valueAsString {
    switch (fieldType) {
      case ExerciseFieldType.reps:
        return value;
      case ExerciseFieldType.weight:
        return value.truncateZeros;
      case ExerciseFieldType.duration:
        if(value.isEmpty) {
          return 'None';
        } else {
          return Timed.fromSeconds(int.parse(value)).toString();
        }
      case ExerciseFieldType.distance:
        return value.truncateZeros;
      case ExerciseFieldType.bodyWeight:
        return value;
      case ExerciseFieldType.weighted:
        return value.truncateZeros;
      case ExerciseFieldType.assisted:
        return value.truncateZeros;
    }
  }

  bool get requiresBar {
    switch (fieldType) {
      case ExerciseFieldType.reps:
        return false;
      case ExerciseFieldType.weight:
        return true;
      case ExerciseFieldType.duration:
        return false;
      case ExerciseFieldType.distance:
        return false;
      case ExerciseFieldType.bodyWeight:
        return false;
      case ExerciseFieldType.weighted:
        return true;
      case ExerciseFieldType.assisted:
        return true;
    }
  }

  String toShortString() {
    switch (fieldType) {
      case ExerciseFieldType.reps:
        return value.truncateZeros;
      case ExerciseFieldType.weight:
        return value.truncateZeros;
      case ExerciseFieldType.duration:
        return Timed.fromSeconds(valueAsDouble.toInt()).toString();
      case ExerciseFieldType.distance:
        return value.truncateZeros;
      case ExerciseFieldType.bodyWeight:
        return value;
      case ExerciseFieldType.weighted:
        return value.truncateZeros;
      case ExerciseFieldType.assisted:
        return value.truncateZeros;
    }
  }

  @override
  String toString() {
    return 'ExerciseSetData{id: $id, value: $value, fieldType: $fieldType, exerciseSetId: $exerciseSetId}';
  }
}
