part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class WorkoutInitialize extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutStart extends WorkoutEvent {
  const WorkoutStart({
    required this.template,
  });

  final Template template;

  @override
  List<Object?> get props => [
    template,
  ];
}

class WorkoutUpdate extends WorkoutEvent {
  const WorkoutUpdate({
    required this.workout,
  });

  final Workout? workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}

class WorkoutDelete extends WorkoutEvent {
  const WorkoutDelete({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}