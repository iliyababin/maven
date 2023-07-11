part of 'user_bloc.dart';

enum UserStatus {
  loading,
  loaded,
  error,
}

extension UserStatusExtension on UserStatus {
  bool get isLoading => this == UserStatus.loading;
  bool get isLoaded => this == UserStatus.loaded;
  bool get isError => this == UserStatus.error;
}

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.loading,
    this.user,
  });

  final UserStatus status;
  final User? user;

  UserState copyWith({
    UserStatus? status,
    User? user,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
  ];
}