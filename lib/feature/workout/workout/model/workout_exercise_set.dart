import 'package:floor/floor.dart';

import '../../template/model/template_exercise_set.dart';
import 'workout.dart';
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
  int? workoutExerciseSetId;

  @ColumnInfo(name: 'option_1')
  int option_1;

  @ColumnInfo(name: 'option_2')
  int? option_2;

  @ColumnInfo(name: 'checked')
  int checked;

  @ColumnInfo(name: 'workout_exercise_group_id')
  int workoutExerciseGroupId;

  @ColumnInfo(name: 'workout_id')
  int workoutId;

  WorkoutExerciseSet({
    this.workoutExerciseSetId,
    required this.option_1,
    this.option_2,
    required this.checked,
    required this.workoutExerciseGroupId,
    required this.workoutId,
  });

  WorkoutExerciseSet copyWith({
    int? workoutExerciseSetId,
    int? option_1,
    int? option_2,
    int? checked,
    int? workoutExerciseGroupId,
    int? workoutId,
  }) {
    return WorkoutExerciseSet(
      workoutExerciseSetId: workoutExerciseSetId ?? this.workoutExerciseSetId,
      option_1: option_1 ?? this.option_1,
      option_2: option_2 ?? this.option_2,
      checked: checked ?? this.checked,
      workoutExerciseGroupId: workoutExerciseGroupId ?? this.workoutExerciseGroupId,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  static WorkoutExerciseSet exerciseSetToWorkoutExerciseSet(TemplateExerciseSet exerciseSet, int workoutExerciseGroupId, int workoutId) {
    return WorkoutExerciseSet(
      workoutExerciseGroupId: workoutExerciseGroupId,
      workoutId: workoutId,
      option_1: exerciseSet.option1,
      option_2: exerciseSet.option2,
      checked: 0,
    );
  }
}
