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
    on<SettingChangeWeightUnit>(_changeWeightUnit);
  }

  final SettingDao settingDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.getSetting();
    int themeId = await settingDao.getThemeId() ?? 1;

    final AppTheme theme = AppTheme.themes.firstWhere((theme) => theme.id == themeId);

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: Setting(
        theme: theme,
        themes: AppTheme.themes,
        weightUnit: setting!.weightUnit,
        locale: Locale(setting.languageCode, setting.countryCode),
        username: setting.username,
        description: setting.description,
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
    if (state.setting!.locale == event.locale) return;
    emit(state.copyWith(status: SettingStatus.loading));

    S.load(event.locale);

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        locale: event.locale,
      ),
    ));
  }

  Future<void> _changeWeightUnit(SettingChangeWeightUnit event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.getSetting();

    await settingDao.updateSetting(setting!.copyWith(
      weightUnit: event.weightUnit,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        weightUnit: event.weightUnit,
      ),
    ));
  }
}
