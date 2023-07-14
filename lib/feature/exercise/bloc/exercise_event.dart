part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();
}

class ExerciseInitialize extends ExerciseEvent {
  const ExerciseInitialize();

  @override
  List<Object?> get props => [];
}

class ExerciseAdd extends ExerciseEvent {
  const ExerciseAdd({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  List<Object?> get props => [
    exercise,
  ];
}

class ExerciseUpdate extends ExerciseEvent {
  const ExerciseUpdate({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  List<Object?> get props => [
    exercise,
  ];
}