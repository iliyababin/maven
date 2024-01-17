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
class BaseExerciseSet {
  BaseExerciseSet({
    this.id,
    required this.type,
    required this.checked,
    required this.exerciseGroupId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'exercise_set_type')
  ExerciseSetType type;

  @ColumnInfo(name: 'checked')
  bool checked;

  @ColumnInfo(name: 'exercise_group_id')
  int exerciseGroupId;
}
