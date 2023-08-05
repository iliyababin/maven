import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../database/database.dart';
import '../../../generated/l10n.dart';
import '../../../theme/theme.dart';
import '../settings.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required this.settingDao,
    required this.appThemeDao,
  }) : super(const SettingState()) {
    on<SettingInitialize>(_initialize);
    on<SettingAddTheme>(_addTheme);
    on<SettingChangeTheme>(_changeTheme);
    on<SettingChangeLocale>(_changeLocale);
    on<SettingChangeUnits>(_changeUnit);
    on<SettingUpdate>(_update);
  }

  final SettingDao settingDao;
  final AppThemeDao appThemeDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: await _fetchSetting(),
      packageInfo: packageInfo,
    ));
  }

  Future<void> _addTheme(SettingAddTheme event, Emitter<SettingState> emit) async {
    emit(state.copyWith(
      status: SettingStatus.loading,
    ));

    appThemeDao.add(BaseAppTheme(
      name: event.theme.name,
      brightness: event.theme.brightness,
      background: event.theme.options.color.background,
      primary: event.theme.options.color.primary,
      onPrimary: event.theme.options.color.onPrimary,
      primaryContainer: event.theme.options.color.primaryContainer,
      onPrimaryContainer: event.theme.options.color.onPrimaryContainer,
      secondary: event.theme.options.color.secondary,
      onSecondary: event.theme.options.color.onSecondary,
      secondaryContainer: event.theme.options.color.secondaryContainer,
      onSecondaryContainer: event.theme.options.color.onSecondaryContainer,
      onBackground: event.theme.options.color.onBackground,
      surface: event.theme.options.color.surface,
      onSurface: event.theme.options.color.onSurface,
      onSurfaceVariant: event.theme.options.color.onSurfaceVariant,
      outline: event.theme.options.color.outline,
      outlineVariant: event.theme.options.color.outlineVariant,
      inversePrimary: event.theme.options.color.inversePrimary,
      inverseSurface: event.theme.options.color.inverseSurface,
      onInverseSurface: event.theme.options.color.onInverseSurface,
      success: event.theme.options.color.success,
      onSuccess: event.theme.options.color.onSuccess,
      successContainer: event.theme.options.color.successContainer,
      onSuccessContainer: event.theme.options.color.onSuccessContainer,
      error: event.theme.options.color.error,
      onError: event.theme.options.color.onError,
      errorContainer: event.theme.options.color.errorContainer,
      onErrorContainer: event.theme.options.color.onErrorContainer,
      shadow: event.theme.options.color.shadow,
      warmup: event.theme.options.color.warmup,
      drop: event.theme.options.color.drop,
      cooldown: event.theme.options.color.cooldown,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: await _fetchSetting(),
    ));
  }

  Future<void> _changeTheme(SettingChangeTheme event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.get();

    await settingDao.modify(setting!.copyWith(
      themeId: event.id,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: await _fetchSetting(),
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
    BaseSetting? setting = await settingDao.get();

    await settingDao.modify(setting!.copyWith(
      unit: event.unit,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: state.setting!.copyWith(
        unit: event.unit,
      ),
    ));
  }

  Future<void> _update(SettingUpdate event, Emitter<SettingState> emit) async {
    BaseSetting? setting = await settingDao.get();

    await settingDao.modify(setting!.copyWith(
      unit: event.setting.unit,
      countryCode: event.setting.locale.countryCode,
      languageCode: event.setting.locale.languageCode,
      themeId: event.setting.theme.id,
      sessionWeeklyGoal: event.setting.sessionWeeklyGoal,
    ));

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: await _fetchSetting(),
    ));
  }

  Future<Setting> _fetchSetting() async {
    BaseSetting? temp = await settingDao.get();

    if(temp == null) {
      await settingDao.add(const BaseSetting.base());
    }

    BaseSetting? setting = await settingDao.get();

    List<AppTheme> themes = [];

    for(BaseAppTheme baseAppTheme in await appThemeDao.getAll()) {
      themes.add(AppTheme(
        id: baseAppTheme.id!,
        name: baseAppTheme.name,
        brightness: baseAppTheme.brightness,
        path: '',
        options: ThemeOptions(
          color: baseAppTheme
        ),
      ));
    }

    final AppTheme theme = themes.firstWhere((theme) => theme.id == (setting?.themeId ?? 1));

    return Setting(
      theme: theme,
      themes: themes,
      unit: setting!.unit,
      locale: Locale(setting.languageCode, setting.countryCode),
      sessionWeeklyGoal: setting.sessionWeeklyGoal ,
    );
  }
}
