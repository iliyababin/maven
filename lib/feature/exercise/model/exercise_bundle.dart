import 'package:Maven/feature/exercise/model/exercise_group.dart';

import 'exercise.dart';
import 'exercise_set.dart';


class ExerciseBundle {
  Exercise exercise;
  ExerciseGroup exerciseGroup;
  List<ExerciseSet> exerciseSets;

  ExerciseBundle({
    required this.exercise,
    required this.exerciseGroup,
    required this.exerciseSets
  });
}