import 'package:equatable/equatable.dart';

import '../../../database/model/model.dart';

class CompleteExerciseBundle extends Equatable{
  const CompleteExerciseBundle({
    required this.exercise,
    required this.completeExerciseGroup,
    required this.completeExerciseSets,
  });

  final Exercise exercise;
  final CompleteExerciseGroup completeExerciseGroup;
  final List<CompleteExerciseSet> completeExerciseSets;

  @override
  List<Object?> get props => [
    exercise,
    completeExerciseGroup,
    completeExerciseSets,
  ];
}