import '../../workout/model/workout_exercise_group.dart';
import '../../workout/model/workout_exercise_set.dart';
import '../model/exercise.dart';


class WorkoutExerciseGroupBundle {
  Exercise exercise;
  WorkoutExerciseGroup workoutExerciseGroup;
  List<WorkoutExerciseSet> workoutExerciseSets;

  WorkoutExerciseGroupBundle({
    required this.exercise,
    required this.workoutExerciseGroup,
    required this.workoutExerciseSets
  });
}