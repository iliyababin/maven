part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class InitializeWorkoutBloc extends WorkoutEvent {}

class ConvertTemplateToWorkout extends WorkoutEvent {
  final Template template;

  const ConvertTemplateToWorkout({
    required this.template,
  });

  @override
  List<Object> get props => [template];
}

class PauseWorkout extends WorkoutEvent {}

class UnpauseWorkout extends WorkoutEvent {
  final Workout workout;

  const UnpauseWorkout({
    required this.workout,
  });

  @override
  List<Object> get props => [workout];
}

class DeleteActiveWorkout extends WorkoutEvent {}


class AddExercise extends WorkoutEvent{
  final Exercise exercise;

  const AddExercise({
   required this.exercise
  });

  @override
  List<Object> get props => [exercise];
}

class AddActiveExerciseSet extends WorkoutEvent {
  final int activeExerciseGroupId;

  const AddActiveExerciseSet({
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

