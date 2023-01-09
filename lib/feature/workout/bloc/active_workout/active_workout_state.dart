part of 'active_workout_bloc.dart';

enum ActiveWorkoutStatus {
  initial,
  loading,
  success,
  none,
  active,
}

class ActiveWorkoutState extends Equatable {
  const ActiveWorkoutState({
    this.status = ActiveWorkoutStatus.initial,
    this.activeWorkout,
  });

  final ActiveWorkoutStatus status;
  final ActiveWorkout? activeWorkout;

  ActiveWorkoutState copyWith({
    ActiveWorkoutStatus Function()? status,
    ActiveWorkout Function()? activeWorkout
  }) {
    return ActiveWorkoutState(
      status: status != null ? status() : this.status,
      activeWorkout: activeWorkout != null ? activeWorkout() : this.activeWorkout,
    );
  }

  @override
  List<Object?> get props => [
    status,
    activeWorkout,
  ];
}