import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'exercise_field',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ExerciseField extends Equatable {
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

  ExerciseField copyWith({
    int? id,
    int? exerciseId,
    ExerciseFieldType? type,
  }) {
    return ExerciseField(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        exerciseId,
        type,
      ];
}
