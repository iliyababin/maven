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
    this.themeId = 1,
    this.themes = const [],
    this.locale = const Locale('en', 'US'),
  });

  final SettingStatus status;
  final int themeId;
  final List<AppTheme> themes;
  final Locale locale;

  SettingState copyWith({
    SettingStatus? status,
    int? themeId,
    List<AppTheme>? themes,
    Locale? locale,
  }) {
    return SettingState(
      status: status ?? this.status,
      themeId: themeId ?? this.themeId,
      themes: themes ?? this.themes,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
    status,
    themeId,
    themes,
    locale,
  ];
}

