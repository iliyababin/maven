import 'package:floor/floor.dart';

import 'exercise_set.dart';
import 'workout.dart';
import 'workout_exercise_group.dart';

@Entity(
  tableName: 'workout_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: WorkoutExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['workout_id'],
      parentColumns: ['id'],
      entity: Workout,
    ),
  ]
)
class WorkoutExerciseSet extends ExerciseSet {
  const WorkoutExerciseSet({
    super.id,
    required super.type,
    required super.checked,
    required super.exerciseGroupId,
    super.data,
    required this.workoutId,
  });

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  @override
  List<Object?> get props => [
    ...super.props,
    workoutId,
  ];
}
