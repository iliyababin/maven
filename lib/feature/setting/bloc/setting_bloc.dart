import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/dao/setting_dao.dart';
import '../../../database/model/setting.dart';
import '../../../generated/l10n.dart';
import '../../../theme/theme.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required this.settingDao,
  }) : super(const SettingState()) {
    on<SettingInitialize>(_initialize);
    on<SettingChangeTheme>(_changeTheme);
    on<SettingChangeLocale>(_changeLocale);
  }

  final SettingDao settingDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    String languageCode = await settingDao.getLanguageCode() ?? 'en';
    String countryCode = await settingDao.getCountryCode() ?? 'US';
    int? themeId = await settingDao.getThemeId() ?? 0;
    Iterable<AppTheme> theme = AppTheme.themes.where((element) => element.id == themeId);

    emit(state.copyWith(
      status: SettingStatus.loaded,
      currentTheme: theme.isNotEmpty ? theme.first : null,
      themes: AppTheme.themes,
      locale: Locale(languageCode, countryCode),
    ));
  }

  Future<void> _changeTheme(SettingChangeTheme event, Emitter<SettingState> emit) async {
    if (state.currentTheme.id == event.id) return;
    if (!AppTheme.themes.map((e) => e.id).contains(event.id)) return;

    Setting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      themeId: event.id,
    ));

    AppTheme theme = AppTheme.themes.firstWhere((element) => element.id == event.id);

    emit(state.copyWith(
      status: SettingStatus.loaded,
      currentTheme: theme,
    ));
  }

  Future<void> _changeLocale(SettingChangeLocale event, Emitter<SettingState> emit) async {
    if (state.locale == event.locale) return;
    emit(state.copyWith(status: SettingStatus.loading));

    S.load(event.locale);

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      locale: event.locale,
    ));
  }
}
