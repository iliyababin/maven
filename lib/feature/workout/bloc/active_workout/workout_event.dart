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