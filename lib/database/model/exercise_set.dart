import 'package:floor/floor.dart';
import 'package:maven/database/model/routine_set.dart';

import '../../feature/exercise/model/set_type.dart';
import 'model.dart';

class ExerciseSet extends RoutineSet {
  const ExerciseSet({
    super.id,
    required super.exerciseGroupId,
    required super.type,
    required super.checked,
    this.data = const [],
  });

  @ignore
  final List<ExerciseSetData> data;

  @override
  List<Object?> get props => [
    ...super.props,
    data,
  ];

  @override
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