
import '../../common/dto/exercise_set.dart';
import '../../common/model/exercise.dart';

class ExerciseGroup {
  Exercise exercise;
  List<ExerciseSet> exerciseSets;

  ExerciseGroup({
    required this.exercise,
    required this.exerciseSets,
  });
}
