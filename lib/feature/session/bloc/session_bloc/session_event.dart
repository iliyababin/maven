part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class SessionInitialize extends SessionEvent {
  const SessionInitialize();

  @override
  List<Object?> get props => [];
}

class SessionAdd extends SessionEvent {
  const SessionAdd({
    required this.workout,
  });

  final Workout workout;

  @override
  List<Object?> get props => [
    workout,
  ];
}

class SessionUpdate extends SessionEvent {
  const SessionUpdate({
    required this.session,
  });

  final Session session;

  @override
  List<Object?> get props => [
    session,
  ];
}

class SessionDelete extends SessionEvent {
  const SessionDelete({
    required this.session,
  });

  final Session session;

  @override
  List<Object?> get props => [
    session,
  ];
}

class SessionSetSort extends SessionEvent {
  const SessionSetSort({
    required this.sort,
  });

  final SessionSort sort;

  @override
  List<Object?> get props => [
    sort,
  ];
}

class SessionImport extends SessionEvent {
  const SessionImport({
    required this.source,
  });

  final TransferSource source;

  @override
  List<Object?> get props => [
    source,
  ];
}