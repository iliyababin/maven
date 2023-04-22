part of 'workout_detail_bloc.dart';

abstract class WorkoutDetailEvent extends Equatable {
  const WorkoutDetailEvent();
}

class WorkoutDetailInitialize extends WorkoutDetailEvent {
  const WorkoutDetailInitialize();

  @override
  List<Object> get props => [];
}

class WorkoutDetailLoad extends WorkoutDetailEvent {
  const WorkoutDetailLoad({
    required this.workoutId,
  });

  final int workoutId;

  @override
  List<Object> get props => [
    workoutId,
  ];
}

class WorkoutDetailUpdate extends WorkoutDetailEvent {
  const WorkoutDetailUpdate({
    this.workout,
    this.exerciseBundles = const []
  });

  final Workout? workout;
  final List<ExerciseBundle> exerciseBundles;

  @override
  List<Object?> get props => [
    workout,
    exerciseBundles,
  ];
}


