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

class WorkoutPause extends WorkoutEvent {}

class WorkoutUnpause extends WorkoutEvent {
  final Workout workout;

  const WorkoutUnpause({
    required this.workout,
  });

  @override
  List<Object> get props => [workout];
}

class WorkoutDelete extends WorkoutEvent {}

class WorkoutStream extends WorkoutEvent {
  const WorkoutStream({
    this.workout,
  });

  final Workout? workout;
}

class WorkoutsPausedStream extends WorkoutEvent {
  const WorkoutsPausedStream({
    required this.pausedWorkouts,
  });

  final List<Workout> pausedWorkouts;

  @override
  List<Object> get props => [pausedWorkouts];
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