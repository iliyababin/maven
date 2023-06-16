import 'package:floor/floor.dart';

import '../database.dart';

@Entity(tableName: 'workout_exercise_set', foreignKeys: [
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
])
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
  WorkoutExerciseSet copyWith({
    int? id,
    ExerciseSetType? type,
    bool? checked,
    int? exerciseGroupId,
    List<ExerciseSetData>? data,
    int? workoutId,
  }) {
    return WorkoutExerciseSet(
      id: id ?? this.id,
      type: type ?? this.type,
      checked: checked ?? this.checked,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      data: data ?? this.data,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        workoutId,
      ];
}
