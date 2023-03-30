
import '../../exercise/model/exercise.dart';

class ExerciseIncrement {
  const ExerciseIncrement({
    required this.exercise,
    required this.incrementAmount,
  });

  final Exercise exercise;
  final int incrementAmount;
}