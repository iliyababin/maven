
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../enum/weight_unit.dart';
import 'bar.dart';
import 'exercise.dart';
import 'exercise_group.dart';
import 'workout.dart';

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
      parentColumns: ['exercise_id'],
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
    required super.barId,
    required super.exerciseId,
    required this.workoutId,
  });

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  @override
  WorkoutExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    int? barId,
    int? exerciseId,
    int? workoutId,
  }) {
    return WorkoutExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  WorkoutExerciseGroup copyWithNullId() {
    return WorkoutExerciseGroup(
      id: null,
      timer: timer,
      weightUnit: weightUnit,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    timer,
    weightUnit,
    barId,
    exerciseId,
    workoutId,
  ];
}