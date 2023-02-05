part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class WorkoutInitialize extends WorkoutEvent {}

class WorkoutFromTemplate extends WorkoutEvent {
  final Template template;

  const WorkoutFromTemplate({
    required this.template,
  });

  @override
  List<Object> get props => [template];
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

class WorkoutAddExercise extends WorkoutEvent{
  final Exercise exercise;

  const WorkoutAddExercise({
   required this.exercise
  });

  @override
  List<Object> get props => [exercise];
}

class WorkoutExerciseGroupsStream extends WorkoutEvent {
  final List<WorkoutExerciseGroup> workoutExerciseGroups;

  const WorkoutExerciseGroupsStream({
    required this.workoutExerciseGroups
  });

  @override
  List<Object> get props => [workoutExerciseGroups];
}

class WorkoutExerciseSetsStream extends WorkoutEvent {
  final List<WorkoutExerciseSet> workoutExerciseSets;

  const WorkoutExerciseSetsStream({
    required this.workoutExerciseSets
  });

  @override
  List<Object> get props => [workoutExerciseSets];
}

class WorkoutAddWorkoutExerciseSet extends WorkoutEvent {
  final int workoutExerciseGroupId;

  const WorkoutAddWorkoutExerciseSet({
    required this.workoutExerciseGroupId
  });

  @override
  List<Object> get props => [workoutExerciseGroupId];
}

class UpdateActiveExerciseSet extends WorkoutEvent{
  final WorkoutExerciseSet activeExerciseSet;

  const UpdateActiveExerciseSet({
    required this.activeExerciseSet
  });

  @override
  List<Object> get props => [activeExerciseSet];
}

class WorkoutUpdateWorkoutExerciseSet extends WorkoutEvent {

  final WorkoutExerciseSet workoutExerciseSet;

  const WorkoutUpdateWorkoutExerciseSet({
    required this.workoutExerciseSet
  });

  @override
  List<Object> get props => [workoutExerciseSet];
}

class WorkoutDeleteWorkoutExerciseSet extends WorkoutEvent {
  final WorkoutExerciseSet workoutExerciseSet;

  const WorkoutDeleteWorkoutExerciseSet({
    required this.workoutExerciseSet
  });

  @override
  List<Object> get props => [workoutExerciseSet];
}


