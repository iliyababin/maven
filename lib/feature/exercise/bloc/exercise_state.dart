part of 'exercise_bloc.dart';

enum ExerciseStatus {
  loading,
  loaded,
}

extension ExerciseStatusExtension on ExerciseStatus {
  bool get isLoading => this == ExerciseStatus.loading;
  bool get isLoaded => this == ExerciseStatus.loaded;
}

class ExerciseState extends Equatable {
  const ExerciseState({
    this.status = ExerciseStatus.loading,
    this.exercises = const [],
  });

  final ExerciseStatus status;
  final List<Exercise> exercises;

  ExerciseState copyWith({
    ExerciseStatus? status,
    List<Exercise>? exercises,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exercises
  ];
}