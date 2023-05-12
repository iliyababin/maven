
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import 'bar.dart';
import 'complete.dart';
import 'exercise.dart';

@Entity(
  tableName: 'complete_exercise_group',
  primaryKeys: [
    'complete_exercise_group_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['complete_id'],
      parentColumns: ['complete_id'],
      entity: Complete,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['bar_id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise,
    ),
  ],
)
class CompleteExerciseGroup extends Equatable {
  const CompleteExerciseGroup({
    this.completeExerciseGroupId,
    required this.order,
    required this.completeId,
    this.barId,
    required this.exerciseId,
  });

  @ColumnInfo(name: 'complete_exercise_group_id')
  @PrimaryKey(autoGenerate: true)
  final int? completeExerciseGroupId;

  @ColumnInfo(name: 'order')
  final int order;

  @ColumnInfo(name: 'complete_id')
  final int completeId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @override
  List<Object?> get props => [
    completeExerciseGroupId,
    order,
    completeId,
    barId,
    exerciseId,
  ];
}