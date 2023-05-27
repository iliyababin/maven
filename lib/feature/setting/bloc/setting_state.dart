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
    this.currentTheme = AppTheme.dark,
    this.themes = const [],
    this.locale = const Locale('en', 'US'),
  });

  final SettingStatus status;
  final AppTheme currentTheme;
  final List<AppTheme> themes;
  final Locale locale;

  SettingState copyWith({
    SettingStatus? status,
    AppTheme? currentTheme,
    List<AppTheme>? themes,
    Locale? locale,
  }) {
    return SettingState(
      status: status ?? this.status,
      currentTheme: currentTheme ?? this.currentTheme,
      themes: themes ?? this.themes,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentTheme,
    themes,
    locale,
  ];
}

