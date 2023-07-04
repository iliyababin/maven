
import 'package:equatable/equatable.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';

class Workout extends Equatable {
  const Workout({
    required this.routine,
    required this.workoutData,
    this.exerciseGroups = const [],
  });

  final Routine routine;
  final WorkoutData workoutData;
  final List<ExerciseGroup> exerciseGroups;

  Workout copyWith({
    Routine? routine,
    WorkoutData? workoutData,
    List<ExerciseGroup>? exerciseGroups,
  }) {
    return Workout(
      routine: routine ?? this.routine,
      workoutData: workoutData ?? this.workoutData,
      exerciseGroups: exerciseGroups ?? this.exerciseGroups,
    );
  }

  @override
  List<Object?> get props => [
    routine,
    workoutData,
    exerciseGroups,
  ];
}