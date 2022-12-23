import 'package:maven/common/model/exercise.dart';
import 'package:maven/feature/create_workout/model/temp_exercise_set.dart';

class ExerciseBlockData {
  Exercise exercise;
  List<TempExerciseSet> sets;

  ExerciseBlockData({
    required this.exercise,
    required this.sets,
  });
}
