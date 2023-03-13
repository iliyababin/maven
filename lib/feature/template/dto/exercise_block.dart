
import '../../exercise/dto/exercise_set.dart';
import '../../exercise/model/exercise.dart';

class ExerciseGroup {
  ExerciseGroup({
    required this.exerciseGroupId,
    required this.exercise,
    required this.exerciseSets,
    this.barId,
  });

  final int? exerciseGroupId;
  final Exercise exercise;
  final List<ExerciseSet> exerciseSets;
  final int? barId;

  ExerciseGroup copyWith({
    int? exerciseGroupId,
    Exercise? exercise,
    List<ExerciseSet>? exerciseSets,
    int? barId,
  }) {
    return ExerciseGroup(
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      exercise: exercise ?? this.exercise,
      exerciseSets: exerciseSets ?? this.exerciseSets,
      barId: barId ?? this.barId,
    );
  }
}
