part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class SessionInitialize extends SessionEvent {
  const SessionInitialize();

  @override
  List<Object?> get props => [];
}

class SessionAdd extends SessionEvent {
  const SessionAdd({
    required this.workout,
    required this.exerciseBundles,
  });

  final Workout workout;
  final List<ExerciseBundle> exerciseBundles;

  @override
  List<Object?> get props => [
    workout,
    exerciseBundles,
  ];
}