part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  success,
  failure,
  added
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workouts = const [],
  });

  final WorkoutStatus status;
  final List<Workout> workouts;

  Iterable<Workout> get filteredWorkouts => workouts;

  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    List<Workout> Function()? workouts,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workouts: workouts != null ? workouts() : this.workouts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workouts,
  ];
}