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
    this.exerciseGroup,
    this.exerciseSet,
  });

  final ExerciseGroup? exerciseGroup;
  final ExerciseSet? exerciseSet;

  @override
  List<Object?> get props => [
    exerciseGroup,
    exerciseSet,
  ];
}

class WorkoutDetailAdd extends WorkoutDetailEvent {
  const WorkoutDetailAdd({
    this.exercise,
    this.exerciseSet,
  });

  final Exercise? exercise;
  final ExerciseSet? exerciseSet;

  @override
  List<Object?> get props => [
    exercise,
    exerciseSet,
  ];
}

class WorkoutDetailDelete extends WorkoutDetailEvent {
  const WorkoutDetailDelete({
    this.exerciseGroup,
    this.exerciseSet,
  });

  final ExerciseGroup? exerciseGroup;
  final ExerciseSet? exerciseSet;

  @override
  List<Object?> get props => [
    exerciseGroup,
    exerciseSet,
  ];
}


