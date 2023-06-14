import 'package:floor/floor.dart';

import '../../feature/exercise/model/set_type.dart';

enum ExerciseSetOptionType {
  assisted,
  reps,
  distance,
  duration,
  weight,
  weighted,
}

abstract class ExerciseSetOption<T> {
  const ExerciseSetOption({
    this.id,
    required this.exerciseSetId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'exercise_set_id')
  final int exerciseSetId;

  String get value;

  ExerciseSetOptionType get type;
}

class AssistanceOption extends ExerciseSetOption<int> {
  const AssistanceOption({
    super.id,
    required super.exerciseSetId,
    this.assistance = 0.0,
  });

  final double assistance;

  @override
  get value => super.exerciseSetId.toString();

  @override
  ExerciseSetOptionType get type => ExerciseSetOptionType.assisted;
}

class RepsOption extends ExerciseSetOption<int> {
  const RepsOption({
    super.id,
    required super.exerciseSetId,
    this.reps = 0,
  });

  final int reps;

  @override
  get value => super.exerciseSetId.toString();

  @override
  ExerciseSetOptionType get type => ExerciseSetOptionType.reps;
}

class DurationOption extends ExerciseSetOption<Duration> {
  const DurationOption({
    super.id,
    required super.exerciseSetId,
    this.duration = Duration.zero,
  });

  final Duration duration;

  @override
  get value => duration.toString();

  @override
  ExerciseSetOptionType get type => ExerciseSetOptionType.duration;
}


class ExerciseSet {
  const ExerciseSet({
    this.id,
    required this.type,
    required this.exerciseGroupId,
    required this.options,
  });

  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'type')
  final SetType type;

  @ColumnInfo(name: 'exercise_group_id')
  final int exerciseGroupId;

  @ignore
  final List<ExerciseSetOption> options;

  ExerciseSet copyWith({
    int? id,
    SetType? type,
    int? exerciseGroupId,
    List<ExerciseSetOption>? options,
  }) {
    return ExerciseSet(
      id: id ?? this.id,
      type: type ?? this.type,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      options: options ?? this.options,
    );
  }
}


/*
* static final _exerciseTypes = {
    'Assisted · Body-weight': assistedBodyweight,
    'Body-weight · Reps': bodyweightReps,
    'Distance · Duration': distanceAndDuration,
    'Duration': duration,
    'Weight · Distance': weightAndDistance,
    'Weight · Reps': weightAndReps,
    'Weighted · Body-weight': weightedBodyweight,
  };
*/