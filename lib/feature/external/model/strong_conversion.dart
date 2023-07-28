import '../../exercise/exercise.dart';
import '../external.dart';

class StrongConversion {
  const StrongConversion(
    this.exerciseName,
    this.exerciseId,
    this.convert,
  );

  final String exerciseName;
  final int exerciseId;
  final List<ExerciseSetData> Function(StrongRow row) convert;
}
