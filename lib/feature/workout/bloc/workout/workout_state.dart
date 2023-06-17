part of 'workout_bloc.dart';

enum WorkoutStatus {
  loading,
  none,
  active,
  error,
}

extension WorkoutStatusExtension on WorkoutStatus {
  bool get isLoading => this == WorkoutStatus.loading;
  bool get isNone => this == WorkoutStatus.none;
  bool get isActive => this == WorkoutStatus.active;
  bool get isError => this == WorkoutStatus.error;
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.loading,
    this.workout,
    this.exerciseBundles = const [],
    this.pausedWorkouts = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<ExerciseBundle> exerciseBundles;

  final List<Workout> pausedWorkouts;

  WorkoutState copyWith({
    WorkoutStatus? status,
    Workout? workout,
    List<ExerciseBundle>? exerciseBundles,
    List<Workout>? pausedWorkouts,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
      pausedWorkouts: pausedWorkouts ?? this.pausedWorkouts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    exerciseBundles,
    pausedWorkouts,
  ];
}