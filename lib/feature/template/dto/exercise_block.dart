
import '../../exercise/model/exercise.dart';
import '../../exercise/model/exercise_group.dart';
import '../../exercise/model/exercise_set.dart';

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
      exerciseSets: exerciseSets != null
          ? List<ExerciseSet>.from(exerciseSets.map((e) => e.copyWith()))
          : List<ExerciseSet>.from(this.exerciseSets.map((e) => e.copyWith())),
      barId: barId ?? this.barId,
    );
  }
}

