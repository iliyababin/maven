part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  success,
  failure,
  added,
  reordering
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workouts = const [],
    this.workoutFolders = const [],
  });

  final WorkoutStatus status;
  final List<Workout> workouts;
  final List<WorkoutFolder> workoutFolders;

  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    List<Workout> Function()? workouts,
    List<WorkoutFolder> Function()? workoutFolders,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workouts: workouts != null ? workouts() : this.workouts,
      workoutFolders: workoutFolders != null ? workoutFolders() : this.workoutFolders,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workouts,
    workoutFolders
  ];
}