import 'package:equatable/equatable.dart';

import '../../../database/model/model.dart';

class SessionExerciseBundle extends Equatable {
  const SessionExerciseBundle({
    required this.exercise,
    required this.sessionExerciseGroup,
    required this.sessionExerciseSets,
  });

  final Exercise exercise;
  final SessionExerciseGroup sessionExerciseGroup;
  final List<SessionExerciseSet> sessionExerciseSets;

  @override
  List<Object?> get props => [
    exercise,
    sessionExerciseGroup,
    sessionExerciseSets,
  ];
}