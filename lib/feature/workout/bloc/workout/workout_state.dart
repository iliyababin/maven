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
    this.exerciseBundles = const [],
  });

  final WorkoutStatus status;
  final List<ExerciseBundle> exerciseBundles;


  WorkoutState copyWith({
    WorkoutStatus? status,
    List<ExerciseBundle>? exerciseBundles,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exerciseBundles,
  ];
}
