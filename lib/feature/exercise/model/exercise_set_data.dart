import '../../../database/database.dart';

class ExerciseSetData extends BaseExerciseSetData {
  ExerciseSetData({
    super.id,
    required super.value,
    required super.fieldType,
    required super.exerciseSetId,
  });

  @override
  ExerciseSetData copyWith({
    int? id,
    String? value,
    ExerciseFieldType? fieldType,
    int? exerciseSetId,
  }) {
    return ExerciseSetData(
      id: id ?? this.id,
      value: value ?? this.value,
      fieldType: fieldType ?? this.fieldType,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    );
  }
}