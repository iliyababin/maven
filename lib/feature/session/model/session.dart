import 'package:equatable/equatable.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';

class Session extends Equatable {
  const Session({
    required this.routine,
    this.exerciseGroups = const [],
    required this.data,
    this.volume = 0,
  });

  final Routine routine;
  final List<ExerciseGroup> exerciseGroups;
  final SessionData data;
  final int volume;

  @override
  List<Object?> get props => [
    routine,
    exerciseGroups,
  ];
}