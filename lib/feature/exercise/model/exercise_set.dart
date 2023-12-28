import '../../../database/database.dart';
import 'exercise_set_data.dart';

class ExerciseSet extends BaseExerciseSet {
  const ExerciseSet({
    super.id,
    required super.type,
    required super.checked,
    required super.exerciseGroupId,
    this.data = const [],
  });

  ExerciseSet.fromBase({
    required BaseExerciseSet baseExerciseSet,
    this.data = const [],
  }) : super(
          id: baseExerciseSet.id,
          type: baseExerciseSet.type,
          checked: baseExerciseSet.checked,
          exerciseGroupId: baseExerciseSet.exerciseGroupId,
        );

  final List<ExerciseSetData> data;

  @override
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
