import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

/// Represents a field associated with an exercise.
///
/// Example usage:
/// ```dart
/// final exerciseField = ExerciseField(
///   exerciseId: 1,
///   type: ExerciseFieldType.sets,
/// );
/// ```
@Entity(
  tableName: 'exercise_field',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ExerciseField extends Equatable {
  // Constructs an instance of [ExerciseField].
  const ExerciseField({
    this.id,
    required this.exerciseId,
    required this.type,
  });

  /// The unique identifier for the exercise field.
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  /// The type of the exercise field.
  @ColumnInfo(name: 'type')
  final ExerciseFieldType type;

  /// The identifier of the exercise associated with this field.
  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @override
  List<Object?> get props => [
        id,
        exerciseId,
        type,
      ];
}
