import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:maven/feature/exercise/model/set_type.dart';

import '../../feature/exercise/model/exercise_set.dart';
import 'workout.dart';
import 'workout_exercise_group.dart';

@Entity(
  tableName: 'workout_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['workout_exercise_group_id'],
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

class WorkoutExerciseSet extends Equatable {
  const WorkoutExerciseSet({
    this.workoutExerciseSetId,
    required this.option_1,
    this.option_2,
    required this.checked,
    required this.setType,
    required this.workoutExerciseGroupId,
    required this.workoutId,
  });

  @ColumnInfo(name: 'workout_exercise_set_id')
  @PrimaryKey(autoGenerate: true)
  final int? workoutExerciseSetId;

  @ColumnInfo(name: 'option_1')
  final int option_1;

  @ColumnInfo(name: 'option_2')
  final int? option_2;

  @ColumnInfo(name: 'checked')
  final int checked;

  @ColumnInfo(name: 'set_type')
  final SetType setType;

  @ColumnInfo(name: 'workout_exercise_group_id')
  final int workoutExerciseGroupId;

  @ColumnInfo(name: 'workout_id')
  final int workoutId;

  ExerciseSet toExerciseSet() {
    return ExerciseSet(
      id: workoutExerciseSetId!,
      checked: checked == 1 ? true : false,
      type: setType,
      exerciseGroupId: workoutExerciseGroupId,
      options: [],
    );
  }

  WorkoutExerciseSet copyWith({
    int? workoutExerciseSetId,
    int? option_1,
    int? option_2,
    int? checked,
    SetType? setType,
    int? workoutExerciseGroupId,
    int? workoutId,
  }) {
    return WorkoutExerciseSet(
      workoutExerciseSetId: workoutExerciseSetId ?? this.workoutExerciseSetId,
      option_1: option_1 ?? this.option_1,
      option_2: option_2 ?? this.option_2,
      checked: checked ?? this.checked,
      setType: setType ?? this.setType,
      workoutExerciseGroupId: workoutExerciseGroupId ?? this.workoutExerciseGroupId,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  WorkoutExerciseSet copyWithNullId() {
    return WorkoutExerciseSet(
      workoutExerciseSetId: null,
      option_1: option_1,
      option_2: option_2,
      checked: checked,
      setType: setType,
      workoutExerciseGroupId: workoutExerciseGroupId,
      workoutId: workoutId,
    );
  }

  @override
  List<Object?> get props => [
    workoutExerciseSetId,
    option_1,
    option_2,
    checked,
    setType,
    workoutExerciseGroupId,
    workoutId,
  ];
}
