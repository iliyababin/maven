

/*


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

  ExerciseFieldType get type;

  void set(T value);

  ExerciseSetOption<T> copyWith({
    int? id,
    int? exerciseSetId,
    T? value,
  });

  @override
  String toString() {
    return 'ExerciseSetOption(id: $id, exerciseSetId: $exerciseSetId, value: $value, type: $type)';
  }
}

ExerciseSetOption getOptionByType(ExerciseFieldType type, int exerciseSetId) {
  switch (type) {
    case ExerciseFieldType.assisted:
      return AssistanceOption(
        exerciseSetId: exerciseSetId,
      );
    case ExerciseFieldType.reps:
      return RepsOption(
        exerciseSetId: exerciseSetId,
      );
    case ExerciseFieldType.duration:
      return DurationOption(
        exerciseSetId: exerciseSetId,
      );
    case ExerciseFieldType.weight:
      return WeightOption(
        exerciseSetId: exerciseSetId,
    );
    case ExerciseFieldType.bodyWeight:
      return BodyWeightOption(
        exerciseSetId: exerciseSetId,
      );
    default:
      throw Exception('Invalid type');
  }
}

class AssistanceOption extends ExerciseSetOption<double> {
  AssistanceOption({
    super.id,
    required super.exerciseSetId,
    this.assistance = 0.0,
  });

  @ColumnInfo(name: 'assistance')
  double assistance;

  @override
  get value => super.exerciseSetId.toString();

  @override
  ExerciseFieldType get type => ExerciseFieldType.assisted;
  
  @override
  void set(double value) => assistance = value;

  @override
  ExerciseSetOption<double> copyWith({
    int? id,
    int? exerciseSetId,
    double? value,
  }) => AssistanceOption(
    id: id ?? this.id,
    exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    assistance: value ?? assistance,
  );
}

class RepsOption extends ExerciseSetOption<int> {
  RepsOption({
    int? id,
    required int exerciseSetId,
    this.reps = 0,
  }) : super(id: id, exerciseSetId: exerciseSetId);

  @ColumnInfo(name: 'reps')
  int reps;

  @override
  String get value => reps.toString();

  @override
  ExerciseFieldType get type => ExerciseFieldType.reps;

  @override
  void set(int value) => reps = value;

  @override
  RepsOption copyWith({
    int? id,
    int? exerciseSetId,
    int? value,
  }) {
    return RepsOption(
      id: id ?? this.id,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      reps: value ?? reps,
    );
  }
}

class DurationOption extends ExerciseSetOption<Duration> {
  DurationOption({
    super.id,
    required super.exerciseSetId,
    this.duration = Duration.zero,
  });

  @ColumnInfo(name: 'duration')
  Duration duration;

  @override
  get value => duration.toString();

  @override
  ExerciseFieldType get type => ExerciseFieldType.duration;

  @override
  void set(Duration value) => duration = value;

  @override
  ExerciseSetOption<Duration> copyWith({
    int? id,
    int? exerciseSetId,
    Duration? value,
  }) => DurationOption(
    id: id ?? this.id,
    exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    duration: value ?? duration,
  );
}

class WeightOption extends ExerciseSetOption<double> {
  WeightOption({
    super.id,
    required super.exerciseSetId,
    this.weight = 0.0,
  });

  @ColumnInfo(name: 'weight')
  double weight;

  @override
  get value => weight.toString();

  @override
  ExerciseFieldType get type => ExerciseFieldType.weight;
  
  @override
  void set(double value) => weight = value;

  @override
  ExerciseSetOption<double> copyWith({
    int? id,
    int? exerciseSetId,
    double? value,
  }) => WeightOption(
    id: id ?? this.id,
    exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    weight: value ?? weight,
  );
}

class BodyWeightOption extends ExerciseSetOption<double> {
  const BodyWeightOption({
    super.id,
    required super.exerciseSetId,
    this.bodyWeight = 0.0,
  });

  @ColumnInfo(name: 'body_weight')
  final double bodyWeight;

  @override
  get value => bodyWeight.toString();

  @override
  ExerciseFieldType get type => ExerciseFieldType.bodyWeight;

  @override
  void set(double value) => UnimplementedError('Cannot set body weight');

  @override
  ExerciseSetOption<double> copyWith({
    int? id,
    int? exerciseSetId,
    double? value,
  }) => BodyWeightOption(
    id: id ?? this.id,
    exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    bodyWeight: value ?? bodyWeight,
  );
}
*/

/*
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
}*/


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