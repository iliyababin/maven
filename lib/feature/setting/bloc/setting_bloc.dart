import 'dart:async';

import 'package:Maven/theme/maven_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/dao/setting_dao.dart';
import '../../../database/model/setting.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required this.settingDao,
  }) : super(const SettingState()) {
    on<SettingInitialize>(_initialize);
    on<SettingChangeTheme>(_changeTheme);
  }

  final SettingDao settingDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    String themeId = await settingDao.getThemeId() ?? 'light';

    emit(state.copyWith(
      theme: MavenTheme.defaultThemes.firstWhere((element) => element.id == themeId),
      themes: MavenTheme.defaultThemes,
    ));
  }

  Future<void> _changeTheme(SettingChangeTheme event, Emitter<SettingState> emit) async {
    if (state.theme.id == event.id) return;
    if (!MavenTheme.defaultThemes.map((e) => e.id).contains(event.id)) return;

    Setting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      themeId: event.id,
    ));

    MavenTheme theme = MavenTheme.defaultThemes.firstWhere((element) => element.id == event.id);

    emit(state.copyWith(
      theme: theme,
    ));
  }
}
