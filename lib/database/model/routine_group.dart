import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';

abstract class RoutineGroup extends Equatable {
  const RoutineGroup({
    this.id,
    required this.timer,
    required this.weightUnit,
    required this.exerciseId,
    this.barId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'timer')
  final Timed timer;

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit weightUnit;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  RoutineGroup copyWith();
}

enum WeightUnit {
  kg,
  lb,
}