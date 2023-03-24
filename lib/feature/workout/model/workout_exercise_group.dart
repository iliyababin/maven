
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../equipment/model/bar.dart';
import '../../exercise/dto/exercise_group.dart';
import '../../exercise/model/exercise.dart';
import 'workout.dart';

@Entity(
  tableName: 'workout_exercise_group',
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['bar_id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise,
    ),
    ForeignKey(
      childColumns: ['workout_id'],
      parentColumns: ['workout_id'],
      entity: Workout,
    ),
  ]
)
class WorkoutExerciseGroup extends Equatable{
  const WorkoutExerciseGroup({
    this.workoutExerciseGroupId,
    required this.barId,
    required this.exerciseId,
    required this.workoutId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_exercise_group_id')
  final int? workoutExerciseGroupId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  ExerciseGroup toExerciseGroup() {
    return ExerciseGroup(
      exerciseGroupId: workoutExerciseGroupId!,
      exerciseId: exerciseId,
      barId: barId
    );
  }

  WorkoutExerciseGroup copyWith({
    int? workoutExerciseGroupId,
    int? barId,
    int? exerciseId,
    int? workoutId,
  }) {
    return WorkoutExerciseGroup(
      workoutExerciseGroupId: workoutExerciseGroupId ?? this.workoutExerciseGroupId,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  WorkoutExerciseGroup copyWithNullId() {
    return WorkoutExerciseGroup(
      workoutExerciseGroupId: null,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }


  @override
  List<Object?> get props => [
    workoutExerciseGroupId,
    barId,
    exerciseId,
    workoutId,
  ];

}