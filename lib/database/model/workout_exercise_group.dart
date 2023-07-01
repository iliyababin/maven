import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

@Entity(
  tableName: 'workout_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
    ),
    ForeignKey(
      childColumns: ['workout_id'],
      parentColumns: ['id'],
      entity: Workout,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class WorkoutExerciseGroup extends ExerciseGroup {
  const WorkoutExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.barId,
    required super.exerciseId,
    super.notes = const [],
    required this.workoutId,
  });

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  @override
  WorkoutExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? barId,
    int? exerciseId,
    List<Note>? notes,
    int? workoutId,
  }) {
    return WorkoutExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      notes: notes ?? this.notes,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        workoutId,
      ];
}
