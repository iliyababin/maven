import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
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

    emit(state.copyWith(
      status: SettingStatus.loaded,
      themeId: await settingDao.getThemeId(),
      themes: AppTheme.themes,
      locale: Locale(languageCode, countryCode),
      username: await settingDao.getUsername(),
    ));
  }

  Future<void> _changeTheme(SettingChangeTheme event, Emitter<SettingState> emit) async {
    Setting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      themeId: event.id,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      themeId: event.id,
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
