import 'package:Maven/feature/exercise/dto/exercise_group.dart';

import '../../exercise/model/exercise.dart';
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