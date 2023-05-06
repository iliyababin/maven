import 'package:equatable/equatable.dart';

class ExerciseTypeOption {
  final String value;

  const ExerciseTypeOption._(this.value);

  static const ExerciseTypeOption reps = ExerciseTypeOption._("REPS");
  static const ExerciseTypeOption weight = ExerciseTypeOption._("WEIGHT");
  static const ExerciseTypeOption addWeight = ExerciseTypeOption._("WEIGHT+");
  static const ExerciseTypeOption subtractWeight = ExerciseTypeOption._("WEIGHT-");
  static const ExerciseTypeOption time = ExerciseTypeOption._("TIME");
  static const ExerciseTypeOption distance = ExerciseTypeOption._("DISTANCE");
  static const ExerciseTypeOption duration = ExerciseTypeOption._("DURATION");
}

class ExerciseType extends Equatable {
  final String name;

  final ExerciseTypeOption exerciseTypeOption1;

  final ExerciseTypeOption? exerciseTypeOption2;

  const ExerciseType({
    required this.name,
    required this.exerciseTypeOption1,
    this.exerciseTypeOption2,
  });

  @override
  List<Object?> get props => [
    name,
    exerciseTypeOption1,
    exerciseTypeOption2,
  ];
}

class ExerciseTypes {
  static const assistedBodyweight = ExerciseType(
    name: 'Assisted Body-weight',
    exerciseTypeOption1: ExerciseTypeOption.subtractWeight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  );
  static const bodyweightReps = ExerciseType(
    name: 'Body-weight Reps',
    exerciseTypeOption1: ExerciseTypeOption.reps,
  );
  static const distanceAndDuration = ExerciseType(
    name: 'Distance and Duration',
    exerciseTypeOption1: ExerciseTypeOption.distance,
    exerciseTypeOption2: ExerciseTypeOption.duration,
  );
  static const duration = ExerciseType(
    name: 'Duration',
    exerciseTypeOption1: ExerciseTypeOption.duration,
  );
  static const weightAndDistance = ExerciseType(
    name: 'Weight and Distance',
    exerciseTypeOption1: ExerciseTypeOption.weight,
    exerciseTypeOption2: ExerciseTypeOption.distance,
  );
  static const weightAndReps = ExerciseType(
    name: 'Weight and Reps',
    exerciseTypeOption1: ExerciseTypeOption.weight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  );
  static const weightedBodyweight = ExerciseType(
    name: 'Weighted Body-weight',
    exerciseTypeOption1: ExerciseTypeOption.addWeight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  );

  static final _exerciseTypes = {
    'Assisted Body-weight': assistedBodyweight,
    'Body-weight Reps': bodyweightReps,
    'Distance and Duration': distanceAndDuration,
    'Duration': duration,
    'Weight and Distance': weightAndDistance,
    'Weight and Reps': weightAndReps,
    'Weighted Body-weight': weightedBodyweight,
  };

  static ExerciseType? fromName(String name) => _exerciseTypes[name];
}
