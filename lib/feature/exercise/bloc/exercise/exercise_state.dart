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
    this.message = '',
    this.exercises = const [],
  });

  final ExerciseStatus status;
  final String message;
  final List<Exercise> exercises;

  ExerciseState copyWith({
    ExerciseStatus? status,
    String? message,
    List<Exercise>? exercises,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      message: message ?? this.message,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    exercises
  ];
}