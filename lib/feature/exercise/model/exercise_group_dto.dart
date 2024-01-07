import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../exercise.dart';

part 'exercise_group_dto.g.dart';

@CopyWith()
class ExerciseGroupDto extends BaseExerciseGroup {
  const ExerciseGroupDto({
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

  ExerciseGroupDto.fromBase({
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
  final List<ExerciseSetDto> sets;

/* @override
  ExerciseGroupDto copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    int? routineId,
    List<Note>? notes,
    List<ExerciseSetDto>? sets,
  }) {
    return ExerciseGroupDto(
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
  }*/
}