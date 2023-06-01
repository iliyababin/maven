part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();
}

class ExerciseInitialize extends ExerciseEvent {
  const ExerciseInitialize();

  @override
  List<Object?> get props => [];
}
