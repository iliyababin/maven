/*
part of 'session_exercise_bloc.dart';

abstract class SessionExerciseEvent extends Equatable {
  const SessionExerciseEvent();
}

class SessionExerciseInitialize extends SessionExerciseEvent {
  const SessionExerciseInitialize();

  @override
  List<Object?> get props => [];
}

class SessionExerciseLoad extends SessionExerciseEvent {
const SessionExerciseLoad({
    required this.exerciseId,
  });

  final int exerciseId;

  @override
  List<Object?> get props => [
    exerciseId,
  ];
}*/
