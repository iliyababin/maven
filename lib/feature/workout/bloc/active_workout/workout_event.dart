part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class WorkoutInitialize extends WorkoutEvent {}

class WorkoutStartTemplate extends WorkoutEvent {
  final Template template;

  const WorkoutStartTemplate({
    required this.template,
  });

  @override
  List<Object> get props => [template];
}

class WorkoutStartEmpty extends WorkoutEvent {}

class WorkoutUpdate extends WorkoutEvent {
  const WorkoutUpdate({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object> get props => [workout];
}

class WorkoutItemsUpdate extends WorkoutEvent {
  const WorkoutItemsUpdate({
    this.exerciseGroups = const[],
    this.exerciseSets = const[],
  });

  final List<ExerciseGroup> exerciseGroups;
  final List<ExerciseSet> exerciseSets;

  @override
  List<Object> get props => [
    exerciseGroups,
    exerciseSets,
  ];
}

class WorkoutDelete extends WorkoutEvent {}

class WorkoutExerciseGroupAdd extends WorkoutEvent {
  const WorkoutExerciseGroupAdd({
    required this.exerciseGroup,
  });

  final ExerciseGroup exerciseGroup;

  @override
  List<Object> get props => [
    exerciseGroup,
  ];
}

class WorkoutExerciseGroupUpdate extends WorkoutEvent {
  const WorkoutExerciseGroupUpdate({
    required this.exerciseGroup,
  });

  final ExerciseGroup exerciseGroup;

  @override
  List<Object> get props => [
    exerciseGroup,
  ];
}

class WorkoutExerciseSetAdd extends WorkoutEvent {
  const WorkoutExerciseSetAdd({
    required this.exerciseSet,
  });

  final ExerciseSet exerciseSet;

  @override
  List<Object> get props => [
    exerciseSet,
  ];
}

class WorkoutExerciseSetUpdate extends WorkoutEvent {
  final ExerciseSet exerciseSet;

  const WorkoutExerciseSetUpdate({
    required this.exerciseSet
  });

  @override
  List<Object> get props => [
    exerciseSet
  ];
}

class WorkoutExerciseSetDelete extends WorkoutEvent {
  final ExerciseSet exerciseSet;

  const WorkoutExerciseSetDelete({
    required this.exerciseSet
  });

  @override
  List<Object> get props => [
    exerciseSet
  ];
}


class WorkoutsPausedStream extends WorkoutEvent {
  const WorkoutsPausedStream({
    required this.pausedWorkouts,
  });

  final List<Workout> pausedWorkouts;

  @override
  List<Object> get props => [pausedWorkouts];
}


class WorkoutStream extends WorkoutEvent {
  const WorkoutStream({
    this.workout,
  });

  final Workout? workout;
}

class WorkoutExerciseGroupStream extends WorkoutEvent {
  const WorkoutExerciseGroupStream({
    required this.workoutExerciseGroups,
  });

  final List<WorkoutExerciseGroup> workoutExerciseGroups;

  @override
  List<Object> get props => [workoutExerciseGroups];
}

class WorkoutExerciseSetStream extends WorkoutEvent {
  const WorkoutExerciseSetStream({
    required this.workoutExerciseSets,
  });

  final List<WorkoutExerciseSet> workoutExerciseSets;

  @override
  List<Object> get props => [workoutExerciseSets];
}