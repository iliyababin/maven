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