import '../../../common/common.dart';
import '../../../database/database.dart';
import 'exercise_set.dart';

class ExerciseGroup extends BaseExerciseGroup {
  const ExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.exerciseId,
    required super.barId,
    required super.routineId,
    this.sets = const [],
    this.notes = const [],
  });

  ExerciseGroup.fromBase({
    required BaseExerciseGroup baseExerciseGroup,
    this.sets = const [],
    this.notes = const [],
  }) : super(
          id: baseExerciseGroup.id,
          timer: baseExerciseGroup.timer,
          weightUnit: baseExerciseGroup.weightUnit,
          distanceUnit: baseExerciseGroup.distanceUnit,
          exerciseId: baseExerciseGroup.exerciseId,
          barId: baseExerciseGroup.barId,
          routineId: baseExerciseGroup.routineId,
        );

  final List<Note> notes;
  final List<ExerciseSet> sets;

  @override
  ExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    int? routineId,
    List<Note>? notes,
    List<ExerciseSet>? sets,
  }) {
    return ExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      exerciseId: exerciseId ?? this.exerciseId,
      barId: barId ?? this.barId,
      routineId: routineId ?? this.routineId,
      notes: notes ?? this.notes,
      sets: sets ?? this.sets,
    );
  }
}