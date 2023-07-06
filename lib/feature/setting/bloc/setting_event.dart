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

class SettingChangeWeightUnit extends SettingEvent {
  const SettingChangeWeightUnit({
    required this.weightUnit,
  });

  final WeightUnit weightUnit;

  @override
  List<Object?> get props => [
    weightUnit,
  ];
}