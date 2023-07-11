import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../../../generated/l10n.dart';
import '../../../theme/theme.dart';
import '../setting.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required this.settingDao,
  }) : super(const SettingState()) {
    on<SettingInitialize>(_initialize);
    on<SettingChangeTheme>(_changeTheme);
    on<SettingChangeLocale>(_changeLocale);
    on<SettingChangeUnits>(_changeUnit);
  }

  final SettingDao settingDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.getSetting();

    final AppTheme theme = AppTheme.themes.firstWhere((theme) => theme.id == (setting?.themeId ?? 1));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: Setting(
        theme: theme,
        themes: AppTheme.themes,
        unit: setting!.unit,
        locale: Locale(setting.languageCode, setting.countryCode),
      ),
    ));
  }

  Future<void> _changeTheme(SettingChangeTheme event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      themeId: event.id,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        theme: AppTheme.themes.firstWhere((theme) => theme.id == event.id),
      ),
    ));
  }

  Future<void> _changeLocale(SettingChangeLocale event, Emitter<SettingState> emit) async {
    emit(state.copyWith(
      status: SettingStatus.loading,
    ));

    S.load(event.locale);

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        locale: event.locale,
      ),
    ));
  }

  Future<void> _changeUnit(SettingChangeUnits event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      unit: event.unit,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        unit: event.unit,
      ),
    ));
  }
}
