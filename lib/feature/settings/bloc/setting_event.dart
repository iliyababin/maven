part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class SettingInitialize extends SettingEvent {
  const SettingInitialize();

  @override
  List<Object?> get props => [];
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