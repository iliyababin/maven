import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'workout_exercise_group_note',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: WorkoutExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class WorkoutExerciseGroupNote extends Note {
  const WorkoutExerciseGroupNote({
    super.id,
    required super.data,
    required super.exerciseGroupId,
  });

  @override
  WorkoutExerciseGroupNote copyWith({
    int? id,
    String? data,
    int? exerciseGroupId,
  }) {
    return WorkoutExerciseGroupNote(
      id: id ?? this.id,
      data: data ?? this.data,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }
}