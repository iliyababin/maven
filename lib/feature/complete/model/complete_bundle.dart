
import 'package:equatable/equatable.dart';

import '../../../database/model/model.dart';

class CompleteBundle extends Equatable {
  const CompleteBundle({
    required this.complete,
    required this.completeExerciseGroups,
    required this.completeExerciseSets,
  });

  final Complete complete;
  final List<CompleteExerciseGroup> completeExerciseGroups;
  final List<CompleteExerciseSet> completeExerciseSets;

  @override
  List<Object?> get props => [
    complete,
    completeExerciseGroups,
    completeExerciseSets,
  ];
}