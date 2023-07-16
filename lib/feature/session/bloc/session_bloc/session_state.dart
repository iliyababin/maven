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

enum SessionSort {
  newest,
  oldest,
  volume
}

class SessionState extends Equatable {
  const SessionState({
    this.status = SessionStatus.loading,
    this.sort = SessionSort.newest,
    this.sessions = const [],
  });

  final SessionStatus status;
  final SessionSort sort;
  final List<Session> sessions;

  SessionState copyWith({
    SessionStatus? status,
    SessionSort? sort,
    List<Session>? sessions,
  }) {
    return SessionState(
      status: status ?? this.status,
      sort: sort ?? this.sort,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sort,
    sessions,
  ];
}
