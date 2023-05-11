part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class WorkoutInitialize extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutStart extends WorkoutEvent {
  const WorkoutStart({
    required this.template,
  });

  final Template template;

  @override
  List<Object?> get props => [
    template,
  ];
}

class WorkoutUpdate extends WorkoutEvent {
  const WorkoutUpdate({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}

class WorkoutToggle extends WorkoutEvent {
  const WorkoutToggle({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}

class WorkoutDelete extends WorkoutEvent {
  const WorkoutDelete({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}

class WorkoutExerciseAdd extends WorkoutEvent {
  const WorkoutExerciseAdd({
    this.exerciseGroups,
    this.exerciseSets,
  });

  final List<ExerciseGroup>? exerciseGroups;
  final List<ExerciseSet>? exerciseSets;

  @override
  List<Object?> get props => [
    exerciseGroups,
    exerciseSets,
  ];
}

class WorkoutExerciseUpdate extends WorkoutEvent {
  const WorkoutExerciseUpdate({
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

class WorkoutExerciseDelete extends WorkoutEvent {
  const WorkoutExerciseDelete({
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