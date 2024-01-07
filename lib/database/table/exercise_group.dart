import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

@Entity(
  tableName: 'exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.restrict,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['routine_id'],
      parentColumns: ['id'],
      entity: Routine,
      onDelete: ForeignKeyAction.cascade,
    ),
  ]
)
class BaseExerciseGroup extends Equatable {
  const BaseExerciseGroup({
    this.id,
    required this.timer,
    required this.weightUnit,
    required this.distanceUnit,
    required this.exerciseId,
    required this.barId,
    required this.routineId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'timer')
  final Timed timer;

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit? weightUnit;

  @ColumnInfo(name: 'distance_unit')
  final DistanceUnit? distanceUnit;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ColumnInfo(name: 'routine_id')
  final int? routineId;

  /* @override
  BaseExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    int? routineId,
  }) {
    return BaseExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
      routineId: routineId ?? this.routineId,
    );
  }

  BaseExerciseGroup copyWithNullID() {
    return BaseExerciseGroup(
      id: null,
      timer: timer,
      weightUnit: weightUnit,
      distanceUnit: distanceUnit,
      exerciseId: exerciseId,
      barId: barId,
      routineId: routineId,
    );
  }*/

  @override
  List<Object?> get props => [
        id,
        timer,
        weightUnit,
        distanceUnit,
        exerciseId,
        barId,
        routineId,
      ];
}
