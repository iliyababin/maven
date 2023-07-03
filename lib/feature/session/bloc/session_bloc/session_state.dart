/*
part of 'session_bloc.dart';

enum CompleteStatus {
  initial,
  loading,
  loaded,
  error,
}

extension SessionStatusExtension on CompleteStatus {
  bool get isInitial => this == CompleteStatus.initial;
  bool get isLoading => this == CompleteStatus.loading;
  bool get isLoaded => this == CompleteStatus.loaded;
  bool get isError => this == CompleteStatus.error;
}

class SessionState extends Equatable {
  const SessionState({
    this.status = CompleteStatus.initial,
    this.completeBundles = const [],
  });

  final CompleteStatus status;
  final List<SessionBundle> completeBundles;

  SessionState copyWith({
    CompleteStatus Function()? status,
    List<SessionBundle> Function()? completeBundles,
  }) {
    return SessionState(
      status: status != null ? status() : this.status,
      completeBundles: completeBundles != null ? completeBundles() : this.completeBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    completeBundles,
  ];
}
*/
