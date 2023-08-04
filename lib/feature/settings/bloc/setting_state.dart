part of 'setting_bloc.dart';

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

class SettingState extends Equatable {
  const SettingState({
    this.status = SettingStatus.initial,
    this.setting,
    this.packageInfo,
  });

  final SettingStatus status;
  final Setting? setting;
  final PackageInfo? packageInfo;

  SettingState copyWith({
    SettingStatus? status,
    Setting? setting,
    PackageInfo? packageInfo,
  }) {
    return SettingState(
      status: status ?? this.status,
      setting: setting ?? this.setting,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }

  @override
  List<Object?> get props => [
    status,
    setting,
    packageInfo,
  ];
}

