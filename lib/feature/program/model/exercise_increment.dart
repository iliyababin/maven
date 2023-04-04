
import '../../exercise/model/exercise.dart';
import 'Modifier.dart';

class ExerciseIncrement extends Modifier {
  ExerciseIncrement({
    required this.exercise,
    required this.incrementAmount,
  });

  final Exercise exercise;
  final int incrementAmount;
}