import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../external.dart';

StrongConversion? getByExerciseName(String name) {
  for (StrongConversion conversion in _conversions) {
    if (conversion.exerciseName == name) {
      return conversion;
    }
  }
  return null;
}

List<StrongConversion> _conversions = [
  StrongConversion(
    'Deadlift (Barbell)',
    8,
    (row) {
      return [
        ExerciseSetData(
          fieldType: ExerciseFieldType.weight,
          exerciseSetId: -1,
          value: row.weight.toString(),
        ),
        ExerciseSetData(
          fieldType: ExerciseFieldType.reps,
          exerciseSetId: -1,
          value: row.reps.toString(),
        ),
      ];
    },
  ),
  StrongConversion(
    'Bench Press (Barbell)',
    2,
    (row) {
      return [
        ExerciseSetData(
          fieldType: ExerciseFieldType.weight,
          exerciseSetId: -1,
          value: row.weight.toString(),
        ),
        ExerciseSetData(
          fieldType: ExerciseFieldType.reps,
          exerciseSetId: -1,
          value: row.reps.toString(),
        ),
      ];
    },
  ),
  StrongConversion(
    'Lat Pulldown (Cable)',
    9,
    (row) {
      return [
        ExerciseSetData(
          fieldType: ExerciseFieldType.weight,
          exerciseSetId: -1,
          value: row.weight.toString(),
        ),
        ExerciseSetData(
          fieldType: ExerciseFieldType.reps,
          exerciseSetId: -1,
          value: row.reps.toString(),
        ),
      ];
    },
  ),
];