import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

class ExerciseGroup extends Equatable {
  const ExerciseGroup({
    this.id,
    required this.timer,
    required this.weightUnit,
    required this.distanceUnit,
    required this.exerciseId,
    required this.barId,
    required this.notes,
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

  @ignore
  final List<Note> notes;

  ExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    List<Note>? notes,
  }) {
    return ExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timer,
        weightUnit,
        distanceUnit,
        exerciseId,
        barId,
        notes,
      ];
}
