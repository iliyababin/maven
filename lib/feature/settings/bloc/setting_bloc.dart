import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../database/database.dart';
import '../../../generated/l10n.dart';
import '../../theme/theme.dart';
import '../settings.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required this.settingDao,
    required this.themeDao,
    required this.themeColorDao,
  }) : super(const SettingState()) {
    on<SettingInitialize>(_initialize);
    on<SettingChangeLocale>(_changeLocale);
    on<SettingChangeUnits>(_changeUnit);
    on<SettingUpdate>(_update);
  }

  final SettingDao settingDao;
  final AppThemeDao themeDao;
  final AppThemeColorDao themeColorDao;

  Future<void> _initialize(SettingInitialize event, Emitter<SettingState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    emit(state.copyWith(
      status: SettingStatus.loaded,
      setting: await _fetchSetting(),
      packageInfo: packageInfo,
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


    return Setting(
      unit: setting!.unit,
      locale: Locale(setting.languageCode, setting.countryCode),
      sessionWeeklyGoal: setting.sessionWeeklyGoal ,
    );
  }
}
