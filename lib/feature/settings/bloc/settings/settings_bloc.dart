import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../database/database.dart';
import '../../../../generated/l10n.dart';
import '../../settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.settingsService,
  }) : super(const SettingsState()) {
    on<SettingsInitialize>(_initialize);
    on<SettingsUpdate>(_update);
  }

  final SettingsService settingsService;

  Future<void> _initialize(SettingsInitialize event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
      status: SettingStatus.loaded,
      settings: await settingsService.get(),
      packageInfo: await settingsService.getPackageInfo(),
    ));
  }

  Future<void> _update(SettingsUpdate event, Emitter<SettingsState> emit) async {
    Settings settings = await settingsService.update(event.settings);

    S.load(event.settings.locale);

    emit(state.copyWith(
      settings: settings,
    ));
  }
}
