
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../../feature/exercise/model/exercise_group.dart';
import 'bar.dart';
import 'exercise.dart';
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
    required this.restTimed,
    required this.barId,
    required this.exerciseId,
    required this.workoutId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_exercise_group_id')
  final int? workoutExerciseGroupId;

  @ColumnInfo(name: 'rest_timed')
  final Timed restTimed;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  ExerciseGroup toExerciseGroup() {
    return ExerciseGroup(
      exerciseGroupId: workoutExerciseGroupId!,
      restTimed: restTimed,
      exerciseId: exerciseId,
      barId: barId
    );
  }

  WorkoutExerciseGroup copyWith({
    int? workoutExerciseGroupId,
    Timed? restTimed,
    int? barId,
    int? exerciseId,
    int? workoutId,
  }) {
    return WorkoutExerciseGroup(
      workoutExerciseGroupId: workoutExerciseGroupId ?? this.workoutExerciseGroupId,
      restTimed: restTimed ?? this.restTimed,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  WorkoutExerciseGroup copyWithNullId() {
    return WorkoutExerciseGroup(
      workoutExerciseGroupId: null,
      restTimed: restTimed,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }


  @override
  List<Object?> get props => [
    workoutExerciseGroupId,
    restTimed,
    barId,
    exerciseId,
    workoutId,
  ];
}