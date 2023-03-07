part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

class ExerciseInitialize extends ExerciseEvent {}

class ExerciseStreamUpdateExercises extends ExerciseEvent {
  const ExerciseStreamUpdateExercises({
    required this.exercises,
  });

  final List<Exercise> exercises;

  @override
  List<Object?> get props => [exercises];
}