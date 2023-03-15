
import '../../exercise/dto/exercise_group.dart';
import '../../exercise/dto/exercise_set.dart';
import '../../exercise/model/exercise.dart';

class ExerciseBlock {
  ExerciseBlock({
    required this.exercise,
    required this.exerciseGroup,
    required this.exerciseSets,
    this.barId,
  });

  Exercise exercise;
  ExerciseGroup exerciseGroup;
  List<ExerciseSet> exerciseSets;
  int? barId;

  ExerciseBlock copyWith({
    Exercise? exercise,
    ExerciseGroup? exerciseGroup,
    List<ExerciseSet>? exerciseSets,
    int? barId,
  }) {
    return ExerciseBlock(
      exercise: exercise ?? this.exercise,
      exerciseGroup: exerciseGroup ?? this.exerciseGroup,
      exerciseSets: exerciseSets ?? this.exerciseSets,
      barId: barId ?? this.barId,
    );
  }
}

