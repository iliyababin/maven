part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  success,
  none,
  active
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.pausedWorkouts = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<Workout> pausedWorkouts;


  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<Workout> Function()? pausedWorkouts,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      pausedWorkouts: pausedWorkouts != null ? pausedWorkouts() : this.pausedWorkouts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    pausedWorkouts,
  ];
}