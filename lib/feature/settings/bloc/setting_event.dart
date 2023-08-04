part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class SettingInitialize extends SettingEvent {
  const SettingInitialize();

  @override
  List<Object?> get props => [];
}

class SettingChangeTheme extends SettingEvent {
  const SettingChangeTheme({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [
    id,
  ];
}

class SettingChangeLocale extends SettingEvent {
  const SettingChangeLocale({
    required this.locale,
  });

  final Locale locale;

  @override
  List<Object?> get props => [
    locale,
  ];
}

class SettingChangeUnits extends SettingEvent {
  const SettingChangeUnits({
    required this.unit,
  });

  final Unit unit;

  @override
  List<Object?> get props => [
    unit,
  ];
}

class SettingUpdate extends SettingEvent {
  const SettingUpdate({
    required this.setting,
  });

  final Setting setting;

  @override
  List<Object?> get props => [
    setting,
  ];
}