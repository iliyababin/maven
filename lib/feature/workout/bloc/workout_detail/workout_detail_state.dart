part of 'workout_detail_bloc.dart';

enum WorkoutDetailStatus {
  initial,
  loading,
  loaded,
  error,
}

extension WorkoutDetailStatusExtension on WorkoutDetailStatus {
  bool get isInitial => this == WorkoutDetailStatus.initial;
  bool get isLoading => this == WorkoutDetailStatus.loading;
  bool get isLoaded => this == WorkoutDetailStatus.loaded;
  bool get isError => this == WorkoutDetailStatus.error;
}

class WorkoutDetailState extends Equatable {
  const WorkoutDetailState({
    this.status = WorkoutDetailStatus.initial,
    this.workout,
    this.exerciseBundles = const [],
  });

  final WorkoutDetailStatus status;
  final Workout? workout;
  final List<ExerciseBundle> exerciseBundles;

  WorkoutDetailState copyWith({
    WorkoutDetailStatus Function()? status,
    Workout Function()? workout,
    List<ExerciseBundle> Function()? exerciseBundles,
  }) {
    return WorkoutDetailState(
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