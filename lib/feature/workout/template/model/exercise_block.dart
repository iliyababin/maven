
import '../../../../common/model/exercise.dart';
import 'temp_exercise_set.dart';

class ExerciseBlockData {
  Exercise exercise;
  List<TempExerciseSet> sets;

  ExerciseBlockData({
    required this.exercise,
    required this.sets,
  });
}
