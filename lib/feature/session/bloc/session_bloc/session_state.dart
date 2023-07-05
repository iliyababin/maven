part of 'session_bloc.dart';

enum SessionStatus {
  loading,
  loaded,
  error,
}

extension SessionStatusExtension on SessionStatus {
  bool get isLoading => this == SessionStatus.loading;
  bool get isLoaded => this == SessionStatus.loaded;
  bool get isError => this == SessionStatus.error;
}

class SessionState extends Equatable {
  const SessionState({
    this.status = SessionStatus.loading,
    this.sessions = const [],
  });

  final SessionStatus status;
  final List<Session> sessions;

  SessionState copyWith({
    SessionStatus? status,
    List<Session>? sessions,
  }) {
    return SessionState(
      status: status ?? this.status,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sessions,
  ];
}
