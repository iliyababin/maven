
import '../../common/dto/exercise_set.dart';
import '../../exercise/model/exercise.dart';

class ExerciseGroup {
  Exercise exercise;
  List<ExerciseSet> exerciseSets;

  ExerciseGroup({
    required this.exercise,
    required this.exerciseSets,
  });
}
