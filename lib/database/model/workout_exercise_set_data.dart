import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'workout_exercise_set_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_set_id'],
      parentColumns: ['id'],
      entity: WorkoutExerciseSet,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class WorkoutExerciseSetData extends ExerciseSetData {
  WorkoutExerciseSetData({
    required super.value,
    required super.fieldType,
    required super.exerciseSetId,
  });
}
