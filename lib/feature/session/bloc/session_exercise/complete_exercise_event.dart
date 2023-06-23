part of 'complete_exercise_bloc.dart';

abstract class CompleteExerciseEvent extends Equatable {
  const CompleteExerciseEvent();
}

class CompleteExerciseInitialize extends CompleteExerciseEvent {
  const CompleteExerciseInitialize();

  @override
  List<Object?> get props => [];
}

class CompleteExerciseLoad extends CompleteExerciseEvent {
const CompleteExerciseLoad({
    required this.exerciseId,
  });

  final int exerciseId;

  @override
  List<Object?> get props => [
    exerciseId,
  ];
}