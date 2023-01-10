part of 'active_workout_bloc.dart';

abstract class ActiveWorkoutEvent extends Equatable {
  const ActiveWorkoutEvent();

  @override
  List<Object> get props => [];
}

class InitializeActiveWorkoutBloc extends ActiveWorkoutEvent {}

class ConvertTemplateToWorkout extends ActiveWorkoutEvent {
  final Template template;

  const ConvertTemplateToWorkout({
    required this.template,
  });

  @override
  List<Object> get props => [template];
}