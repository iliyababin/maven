part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserInitialize extends UserEvent {
  const UserInitialize();

  @override
  List<Object?> get props => [];
}

class UserUpdate extends UserEvent {
  const UserUpdate({
    required this.user,
  });

  final User user;

  @override
  List<Object?> get props => [
    user,
  ];
}