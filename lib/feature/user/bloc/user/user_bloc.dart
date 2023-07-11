import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.userDao,
  }) : super(const UserState()) {
    on<UserInitialize>(_initialize);
    on<UserUpdate>(_update);
  }

  final UserDao userDao;

  Future<void> _initialize(UserInitialize event, Emitter<UserState> emit) async {
    User? user = await userDao.get(1);

    if(user == null) {
      await userDao.add(User.base());
      user = await userDao.get(1);
    }

    emit(state.copyWith(
      status: UserStatus.loaded,
      user: user,
    ));
  }

  Future<void> _update(UserUpdate event, Emitter<UserState> emit) async {
    await userDao.modify(event.user);

    emit(state.copyWith(
      status: UserStatus.loaded,
      user: event.user,
    ));
  }
}
