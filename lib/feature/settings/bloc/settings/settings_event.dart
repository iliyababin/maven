part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsInitialize extends SettingsEvent {
  const SettingsInitialize();

  @override
  List<Object?> get props => [];
}

class SettingsUpdate extends SettingsEvent {
  const SettingsUpdate(this.settings);

  final Settings settings;

  @override
  List<Object?> get props => [settings];
}
