import 'package:Maven/feature/create_workout/model/temp_exercise_set.dart';

import '../../../common/model/exercise.dart';

class ExerciseBlockData {
  Exercise exercise;
  List<TempExerciseSet> sets;

  ExerciseBlockData({
    required this.exercise,
    required this.sets,
  });
}
