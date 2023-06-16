import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

class ExerciseSet extends Equatable {
  const ExerciseSet({
    required this.id,
    required this.type,
    required this.checked,
    required this.exerciseGroupId,
    this.data = const [],
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

  @ignore
  final List<ExerciseSetData> data;

  @override
  List<Object?> get props => [
        id,
        type,
        checked,
        exerciseGroupId,
        data,
      ];

  ExerciseSet copyWith({
    int? id,
    ExerciseSetType? type,
    bool? checked,
    int? exerciseGroupId,
    List<ExerciseSetData>? data,
  }) {
    return ExerciseSet(
      id: id ?? this.id,
      type: type ?? this.type,
      checked: checked ?? this.checked,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      data: data ?? this.data,
    );
  }
}
