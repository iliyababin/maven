import 'package:floor/floor.dart';

import 'exercise.dart';

enum ExerciseFieldType {
  assisted,
  reps,
  distance,
  duration,
  weight,
  weighted,
  bodyWeight;
}

@Entity(
  tableName: 'exercise_field',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ExerciseField {
  const ExerciseField({
    this.id,
    required this.exerciseId,
    required this.type,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'type')
  final ExerciseFieldType type;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;
}

List<ExerciseField> getDefaults() => [
  const ExerciseField(
    exerciseId: 1,
    type: ExerciseFieldType.weight,
  ),
  const ExerciseField(
    exerciseId: 1,
    type: ExerciseFieldType.reps,
  ),
  const ExerciseField(
    exerciseId: 2,
    type: ExerciseFieldType.weight,
  ),
  const ExerciseField(
    exerciseId: 2,
    type: ExerciseFieldType.reps,
  ),
  const ExerciseField(
    exerciseId: 3,
    type: ExerciseFieldType.reps,
  ),
  const ExerciseField(
    exerciseId: 3,
    type: ExerciseFieldType.bodyWeight,
  ),
  const ExerciseField(
    exerciseId: 4,
    type: ExerciseFieldType.assisted,
  ),
  const ExerciseField(
    exerciseId: 4,
    type: ExerciseFieldType.reps,
  ),
  const ExerciseField(
    exerciseId: 5,
    type: ExerciseFieldType.weight,
  ),
  const ExerciseField(
    exerciseId: 5,
    type: ExerciseFieldType.reps,
  ),
  const ExerciseField(
    exerciseId: 6,
    type: ExerciseFieldType.distance,
  ),
  const ExerciseField(
    exerciseId: 6,
    type: ExerciseFieldType.duration,
  ),
  const ExerciseField(
    exerciseId: 7,
    type: ExerciseFieldType.weight,
  ),
  const ExerciseField(
    exerciseId: 7,
    type: ExerciseFieldType.distance,
  ),
  const ExerciseField(
    exerciseId: 7,
    type: ExerciseFieldType.reps,
  ),
];