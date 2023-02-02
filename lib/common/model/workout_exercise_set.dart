import 'package:floor/floor.dart';

import '../../feature/workout/template/model/template_exercise_set.dart';
import '../../feature/workout/workout/model/workout.dart';
import 'workout_exercise_group.dart';

@Entity(
  tableName: 'workout_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['workout_exercise_group_id'],
      parentColumns: ['workout_exercise_group_id'],
      entity: WorkoutExerciseGroup
    ),
    ForeignKey(
      childColumns: ['workout_id'],
      parentColumns: ['workout_id'],
      entity: Workout,
    ),
  ]
)
class WorkoutExerciseSet {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_exercise_set_id')
  int? activeExerciseSetId;

  @ColumnInfo(name: 'weight')
  int? weight;

  @ColumnInfo(name: 'reps')
  int? reps;

  @ColumnInfo(name: 'checked')
  int checked;

  @ColumnInfo(name: 'workout_exercise_group_id')
  int activeExerciseGroupId;

  @ColumnInfo(name: 'workout_id')
  int workoutId;

  WorkoutExerciseSet({
    this.activeExerciseSetId,
    this.weight,
    this.reps,
    required this.checked,
    required this.activeExerciseGroupId,
    required this.workoutId,
  });

  static WorkoutExerciseSet exerciseSetToActiveExerciseSet(TemplateExerciseSet exerciseSet, int activeExerciseGroupId, int workoutId) {
    return WorkoutExerciseSet(
      activeExerciseGroupId: activeExerciseGroupId,
      workoutId: workoutId,
      weight: exerciseSet.weight,
      reps: exerciseSet.reps,
      checked: 0,
    );
  }
}
