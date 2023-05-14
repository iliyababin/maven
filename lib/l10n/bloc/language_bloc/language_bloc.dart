import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/dao/setting_dao.dart';
import '../../../database/model/setting.dart';
import '../../../generated/l10n.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({
    required this.settingDao,
  }) : super(const LanguageState()) {
    on<LanguageInitialize>(_initialize);
    on<LanguageLoad>(_load);
  }

  final SettingDao settingDao;

  void _initialize(LanguageInitialize event, Emitter<LanguageState> emit) async {
    Setting? setting = await settingDao.getSetting();

    String? languageCode = await settingDao.getLanguageCode();
    String? countryCode = await settingDao.getCountryCode();

    emit(LanguageState(locale: Locale(languageCode!, countryCode!)));
  }

  void _load(LanguageLoad event, Emitter<LanguageState> emit) {
    S.load(event.locale);
    emit(LanguageState(locale: event.locale));
  }
}
