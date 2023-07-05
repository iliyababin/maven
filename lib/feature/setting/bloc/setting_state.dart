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
    this.username = 'John Doe',
    this.description = 'Weightlifter',
  });

  final SettingStatus status;
  final int themeId;
  final List<AppTheme> themes;
  final Locale locale;
  final String username;
  final String description;

  SettingState copyWith({
    SettingStatus? status,
    int? themeId,
    List<AppTheme>? themes,
    Locale? locale,
    String? username,
    String? description,
  }) {
    return SettingState(
      status: status ?? this.status,
      themeId: themeId ?? this.themeId,
      themes: themes ?? this.themes,
      locale: locale ?? this.locale,
      username: username ?? this.username,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
    status,
    themeId,
    themes,
    locale,
    username,
    description,
  ];
}

