import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

class ExerciseGroup extends Equatable {
  const ExerciseGroup({
    this.id,
    required this.timer,
    this.weightUnit,
    required this.exerciseId,
    this.barId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'timer')
  final Timed timer;

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit? weightUnit;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  ExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    int? exerciseId,
    int? barId,
  }) {
    return ExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timer,
        weightUnit,
        exerciseId,
        barId,
      ];
}
