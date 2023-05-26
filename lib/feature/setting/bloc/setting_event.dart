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

  final String id;

  @override
  List<Object?> get props => [
    id,
  ];
}