part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class WorkoutInitialize extends WorkoutEvent {
  const WorkoutInitialize();

  @override
  List<Object?> get props => [];
}

class WorkoutStart extends WorkoutEvent {
  const WorkoutStart({
    required this.template,
  });

  final Routine template;

  @override
  List<Object?> get props => [
    template,
  ];
}

class WorkoutFinish extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutUpdate extends WorkoutEvent {
  const WorkoutUpdate();


  @override
  List<Object?> get props => [
  ];
}

class WorkoutToggle extends WorkoutEvent {
  const WorkoutToggle();


  @override
  List<Object?> get props => [
  ];
}

class WorkoutDelete extends WorkoutEvent {
  const WorkoutDelete();


  @override
  List<Object?> get props => [
  ];
}

class WorkoutExerciseAdd extends WorkoutEvent {
  const WorkoutExerciseAdd({
    this.exerciseGroups,
    this.exerciseSets,
  });

  final List<ExerciseGroup>? exerciseGroups;
  final List<BaseExerciseSet>? exerciseSets;

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
  final BaseExerciseSet? exerciseSet;

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
  final BaseExerciseSet? exerciseSet;

  @override
  List<Object?> get props => [
    exerciseGroup,
    exerciseSet,
  ];
}
