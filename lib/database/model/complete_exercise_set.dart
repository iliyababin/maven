
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/exercise/model/set_type.dart';
import 'complete.dart';
import 'complete_exercise_group.dart';

@Entity(
  tableName: 'complete_exercise_set',
  primaryKeys: [
    'complete_exercise_set_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['complete_exercise_group_id'],
      parentColumns: ['complete_exercise_group_id'],
      entity: CompleteExerciseGroup,
    ),
    ForeignKey(
      childColumns: ['complete_id'],
      parentColumns: ['complete_id'],
      entity: Complete,
    ),
  ],
)
class CompleteExerciseSet extends Equatable {
  const CompleteExerciseSet({
    this.completeExerciseSetId,
    required this.option1,
    this.option2,
    required this.setType,
    required this.completeExerciseGroupId,
    required this.completeId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'complete_exercise_set_id')
  final int? completeExerciseSetId;

  @ColumnInfo(name: 'option_1')
  final int option1;

  @ColumnInfo(name: 'option_2')
  final int? option2;

  @ColumnInfo(name: 'set_type')
  final SetType setType;

  @ColumnInfo(name: 'complete_exercise_group_id')
  final int completeExerciseGroupId;

  @ColumnInfo(name: 'complete_id')
  final int completeId;

  @override
  List<Object?> get props => [
    completeExerciseSetId,
    option1,
    option2,
    setType,
    completeExerciseGroupId,
    completeId,
  ];
}