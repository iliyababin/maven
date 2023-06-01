part of 'complete_exercise_bloc.dart';

enum CompleteExerciseStatus {
  initial,
  loading,
  loaded,
}

extension CompleteExerciseStatusExtension on CompleteExerciseStatus {
  bool get isInitial => this == CompleteExerciseStatus.initial;
  bool get isLoading => this == CompleteExerciseStatus.loading;
  bool get isLoaded => this == CompleteExerciseStatus.loaded;
}

class CompleteExerciseState extends Equatable {
  const CompleteExerciseState({
    this.status = CompleteExerciseStatus.initial,
    this.completeBundles = const [],
  });

  final CompleteExerciseStatus status;
  final List<CompleteBundle> completeBundles;

  CompleteExerciseState copyWith({
    CompleteExerciseStatus? status,
    List<CompleteBundle>? completeBundles,
  }) {
    return CompleteExerciseState(
      status: status ?? this.status,
      completeBundles: completeBundles ?? this.completeBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    completeBundles,
  ];
}