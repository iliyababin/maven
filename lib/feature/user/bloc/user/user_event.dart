part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserInitialize extends UserEvent {
  const UserInitialize();

  @override
  List<Object?> get props => [];
}
