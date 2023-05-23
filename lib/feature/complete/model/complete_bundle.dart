
import 'package:equatable/equatable.dart';

import '../../../database/model/model.dart';
import 'complete_exercise_bundle.dart';

class CompleteBundle extends Equatable {
  const CompleteBundle({
    required this.complete,
    required this.completeExerciseBundles,
    required this.volume,
  });

  final Complete complete;
  final List<CompleteExerciseBundle> completeExerciseBundles;
  final double volume;

  @override
  List<Object?> get props => [
    complete,
    completeExerciseBundles,
    volume,
  ];
}