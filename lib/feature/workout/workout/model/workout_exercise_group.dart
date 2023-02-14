
import 'package:floor/floor.dart';

import '../../template/model/exercise.dart';
import 'workout.dart';

@Entity(
  tableName: 'workout_exercise_group',
  foreignKeys: [
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
class WorkoutExerciseGroup {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_exercise_group_id')
  int? workoutExerciseGroupId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  WorkoutExerciseGroup({
    this.workoutExerciseGroupId,
    required this.exerciseId,
    required this.workoutId,
  });

  static WorkoutExerciseGroup exerciseToActiveExerciseGroup(int exerciseId, int workoutId) {
    return WorkoutExerciseGroup(
      exerciseId: exerciseId,
      workoutId: workoutId
    );
  }
}