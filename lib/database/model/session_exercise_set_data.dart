import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'session_exercise_set_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_set_id'],
      parentColumns: ['id'],
      entity: SessionExerciseSet,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class SessionExerciseSetData extends ExerciseSetData {
  SessionExerciseSetData({
    required super.value,
    required super.fieldType,
    required super.exerciseSetId,
  });
}
