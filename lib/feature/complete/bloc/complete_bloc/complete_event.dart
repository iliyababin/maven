part of 'complete_bloc.dart';

abstract class CompleteEvent extends Equatable {
  const CompleteEvent();
}

class CompleteInitialize extends CompleteEvent {
  const CompleteInitialize();

  @override
  List<Object?> get props => [];
}

class CompleteAdd extends CompleteEvent {
  const CompleteAdd({
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