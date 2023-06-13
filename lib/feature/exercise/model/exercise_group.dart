
import '../../../common/model/timed.dart';
import '../../../database/database.dart';
import '../../../database/model/routine_group.dart';

class ExerciseGroup extends RoutineGroup {
  const ExerciseGroup({
    required super.id,
    required super.timer,
    required super.weightUnit,
    required super.exerciseId,
    super.barId,
  });

  @override
  ExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    int? exerciseId,
    int? barId,
  }) {
    return ExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
    );
  }

  WorkoutExerciseGroup toWorkoutExerciseGroup(int workoutId) {
    return WorkoutExerciseGroup(
      id: id,
      timer: timer,
      weightUnit: WeightUnit.lb,
      barId: barId,
      exerciseId: exerciseId,
      workoutId: workoutId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    timer,
    weightUnit,
    exerciseId,
    barId,
  ];
}