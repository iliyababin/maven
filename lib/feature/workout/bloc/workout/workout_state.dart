part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  none,
  active,
  error,
}

extension WorkoutStatusExtension on WorkoutStatus {
  bool get isInitial => this == WorkoutStatus.initial;
  bool get isLoading => this == WorkoutStatus.loading;
  bool get isNone => this == WorkoutStatus.none;
  bool get isActive => this == WorkoutStatus.active;
  bool get isError => this == WorkoutStatus.error;
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.exerciseBundles = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<ExerciseBundle> exerciseBundles;

  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<ExerciseBundle> Function()? exerciseBundles,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      exerciseBundles: exerciseBundles != null ? exerciseBundles() : this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    exerciseBundles,
  ];
}