import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'exercise_set',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: BaseExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class BaseExerciseSet extends Equatable {
  const BaseExerciseSet({
    this.id,
    required this.type,
    required this.checked,
    required this.exerciseGroupId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'exercise_set_type')
  final ExerciseSetType type;

  @ColumnInfo(name: 'checked')
  final bool checked;

  @ColumnInfo(name: 'exercise_group_id')
  final int exerciseGroupId;

  @override
  List<Object?> get props => [
        id,
        type,
        checked,
        exerciseGroupId,
      ];

  BaseExerciseSet copyWith({
    int? id,
    ExerciseSetType? type,
    bool? checked,
    int? exerciseGroupId,
  }) {
    return BaseExerciseSet(
      id: id ?? this.id,
      type: type ?? this.type,
      checked: checked ?? this.checked,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }
}
