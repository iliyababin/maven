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
  });

  final WorkoutStatus status;
  final Workout? workout;

  WorkoutState copyWith({
    WorkoutStatus? status,
    Workout? workout,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
  ];
}
