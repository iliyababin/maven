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

  final int exerciseTypeId;

  final String name;

  final ExerciseTypeOption exerciseTypeOption1;

  final ExerciseTypeOption? exerciseTypeOption2;

  const ExerciseType({
    required this.exerciseTypeId,
    required this.name,
    required this.exerciseTypeOption1,
    this.exerciseTypeOption2,
  });

  @override
  List<Object?> get props => [
    exerciseTypeId,
    name
  ];

}

List<ExerciseType> getExerciseTypes() => [
  const ExerciseType(
    exerciseTypeId: 1,
    name: 'Assisted Body-weight',
    exerciseTypeOption1: ExerciseTypeOption.subtractWeight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  ),
  const ExerciseType(
    exerciseTypeId: 2,
    name: 'Body-weight Reps',
    exerciseTypeOption1: ExerciseTypeOption.reps,
  ),
  const ExerciseType(
    exerciseTypeId: 3,
    name: 'Distance and Duration',
    exerciseTypeOption1: ExerciseTypeOption.distance,
    exerciseTypeOption2: ExerciseTypeOption.duration,
  ),
  const ExerciseType(
    exerciseTypeId: 4,
    name: 'Duration',
    exerciseTypeOption1: ExerciseTypeOption.duration,
  ),
  const ExerciseType(
    exerciseTypeId: 5,
    name: 'Weight and Distance',
    exerciseTypeOption1: ExerciseTypeOption.weight,
    exerciseTypeOption2: ExerciseTypeOption.distance,
  ),
  const ExerciseType(
    exerciseTypeId: 6,
    name: 'Weight and reps',
    exerciseTypeOption1: ExerciseTypeOption.weight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  ),
  const ExerciseType(
    exerciseTypeId: 7,
    name: 'Weighted body-weight',
    exerciseTypeOption1: ExerciseTypeOption.addWeight,
    exerciseTypeOption2: ExerciseTypeOption.reps,
  ),
];
