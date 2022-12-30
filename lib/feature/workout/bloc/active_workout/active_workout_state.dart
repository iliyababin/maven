part of 'active_workout_bloc.dart';

abstract class ActiveWorkoutState extends Equatable {
  const ActiveWorkoutState();
}

class ActiveWorkoutInitial extends ActiveWorkoutState {
  @override
  List<Object> get props => [];
}
