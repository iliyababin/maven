
import 'package:equatable/equatable.dart';

import '../../../database/model/model.dart';
import 'complete_exercise_bundle.dart';

class CompleteBundle extends Equatable {
  const CompleteBundle({
    required this.complete,
    required this.completeExerciseBundles,
  });

  final Complete complete;
  final List<CompleteExerciseBundle> completeExerciseBundles;

  @override
  List<Object?> get props => [
    complete,
    completeExerciseBundles,
  ];
}