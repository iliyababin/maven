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
  }

  final UserDao userDao;

  Future<void> _initialize(UserInitialize event, Emitter<UserState> emit) async {
    User? user = await userDao.get(1);

    if(user == null) {
      await userDao.add(const User.base());
    }

    emit(state.copyWith(
      status: UserStatus.loaded,
      user: user,
    ));
  }
}
