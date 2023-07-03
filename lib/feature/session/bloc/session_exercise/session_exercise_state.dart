/*
part of 'session_exercise_bloc.dart';

enum SessionExerciseStatus {
  initial,
  loading,
  loaded,
}

extension SessionExerciseStatusExtension on SessionExerciseStatus {
  bool get isInitial => this == SessionExerciseStatus.initial;
  bool get isLoading => this == SessionExerciseStatus.loading;
  bool get isLoaded => this == SessionExerciseStatus.loaded;
}

class SessionExerciseState extends Equatable {
  const SessionExerciseState({
    this.status = SessionExerciseStatus.initial,
    this.sessionBundles = const [],
  });

  final SessionExerciseStatus status;
  final List<SessionBundle> sessionBundles;

  SessionExerciseState copyWith({
    SessionExerciseStatus? status,
    List<SessionBundle>? sessionBundles,
  }) {
    return SessionExerciseState(
      status: status ?? this.status,
      sessionBundles: sessionBundles ?? this.sessionBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sessionBundles,
  ];
}*/
