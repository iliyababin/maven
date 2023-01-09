part of 'active_workout_bloc.dart';

abstract class ActiveWorkoutEvent extends Equatable {
  const ActiveWorkoutEvent();

  @override
  List<Object> get props => [];
}

class InitializeActiveWorkoutBloc extends ActiveWorkoutEvent {}

class ConvertTemplateToWorkout extends ActiveWorkoutEvent {
  final Workout workout;

  const ConvertTemplateToWorkout({
    required this.workout,
  });

  @override
  List<Object> get props => [workout];
}