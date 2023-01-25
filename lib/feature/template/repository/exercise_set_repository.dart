import '../../../common/model/exercise_set.dart';

abstract class ExerciseSetRepository {

  Future<int> addExerciseSet(ExerciseSet exerciseSet);
}