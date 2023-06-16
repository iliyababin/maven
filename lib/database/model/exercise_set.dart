import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/exercise/model/set_type.dart';
import 'model.dart';

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

  @ColumnInfo(name: 'set_type')
  final SetType type;

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
    int? exerciseGroupId,
    SetType? type,
    bool? checked,
    List<ExerciseSetData>? data,
  }) {
    return ExerciseSet(
      id: id ?? this.id,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      type: type ?? this.type,
      checked: checked ?? this.checked,
      data: data ?? this.data,
    );
  }
}