
import 'package:equatable/equatable.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';

class Workout extends Equatable {
  const Workout({
    required this.routine,
    required this.data,
    this.exerciseGroups = const [],
  });

  final Routine routine;
  final WorkoutData data;
  final List<ExerciseGroupDto> exerciseGroups;

  Workout copyWith({
    Routine? routine,
    WorkoutData? data,
    List<ExerciseGroupDto>? exerciseGroups,
  }) {
    return Workout(
      routine: routine ?? this.routine,
      data: data ?? this.data,
      exerciseGroups: exerciseGroups ?? this.exerciseGroups,
    );
  }

  @override
  List<Object?> get props => [
    routine,
    data,
    exerciseGroups,
  ];
}