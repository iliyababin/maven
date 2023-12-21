part of 'settings_bloc.dart';

enum SettingStatus {
  initial,
  loading,
  loaded,
}

extension SettingStatusX on SettingStatus {
  bool get isInitial => this == SettingStatus.initial;
  bool get isLoading => this == SettingStatus.loading;
  bool get isLoaded => this == SettingStatus.loaded;
}

class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingStatus.initial,
    this.settings,
    this.packageInfo,
  });

  final SettingStatus status;
  final Settings? settings;
  final PackageInfo? packageInfo;

  SettingsState copyWith({
    SettingStatus? status,
    Settings? settings,
    PackageInfo? packageInfo,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        settings,
        packageInfo,
      ];
}

