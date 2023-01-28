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

class WorkoutAddActiveExerciseSet extends WorkoutEvent {
  final int activeExerciseGroupId;

  const WorkoutAddActiveExerciseSet({
    required this.activeExerciseGroupId
  });

  @override
  List<Object> get props => [activeExerciseGroupId];
}

class UpdateActiveExerciseSet extends WorkoutEvent{
  final ActiveExerciseSet activeExerciseSet;

  const UpdateActiveExerciseSet({
    required this.activeExerciseSet
  });

  @override
  List<Object> get props => [activeExerciseSet];
}

class DeleteActiveExerciseSet extends WorkoutEvent {
  final int activeExerciseSetId;

  const DeleteActiveExerciseSet({
    required this.activeExerciseSetId
  });

  @override
  List<Object> get props => [activeExerciseSetId];
}

