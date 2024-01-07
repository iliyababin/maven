import 'package:equatable/equatable.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';

class Session extends Equatable {
  const Session({
    required this.routine,
    this.exerciseGroups = const [],
    required this.data,
    this.volume = 0,
    this.musclePercentages = const {},
  });

  final Routine routine;
  final List<ExerciseGroupDto> exerciseGroups;
  final SessionData data;
  final double volume;
  final Map<Muscle, double> musclePercentages;

  Session copyWith({
    Routine? routine,
    List<ExerciseGroupDto>? exerciseGroups,
    SessionData? data,
    double? volume,
    Map<Muscle, double>? musclePercentages,
  }) {
    return Session(
      routine: routine ?? this.routine,
      exerciseGroups: exerciseGroups ?? this.exerciseGroups,
      data: data ?? this.data,
      volume: volume ?? this.volume,
      musclePercentages: musclePercentages ?? this.musclePercentages,
    );
  }

  @override
  List<Object?> get props => [
    routine,
    exerciseGroups,
  ];
}