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
    required this.routine,
  });

  final Routine routine;

  @override
  List<Object?> get props => [
    routine,
  ];
}

class WorkoutFinish extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

enum ExerciseGroupAction {
  add,
  update,
  delete,
}


class WorkoutExerciseGroup extends WorkoutEvent {
  const WorkoutExerciseGroup({
    required this.action,
    this.exerciseGroups = const [],
  });

  final ExerciseGroupAction action;
  final List<ExerciseGroup> exerciseGroups;

  @override
  List<Object?> get props => [
    action,
    exerciseGroups,
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
