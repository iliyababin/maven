part of 'theme_bloc.dart';

enum ThemeStatus {
  loading,
  loaded,
}

extension ThemeStatusX on ThemeStatus {
  bool get isLoading => this == ThemeStatus.loading;
  bool get isLoaded => this == ThemeStatus.loaded;
}

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatus.loading,
    this.theme = const AppTheme.empty(),
    this.light = lightTheme,
    this.dark = darkTheme,
    this.themes = const [],
  });

  final ThemeStatus status;
  final AppTheme theme;
  final AppTheme light;
  final AppTheme dark;
  final List<AppTheme> themes;

  ThemeState copyWith({
    ThemeStatus? status,
    AppTheme? theme,
    List<AppTheme>? themes,
  }) {
    return ThemeState(
      status: status ?? this.status,
      theme: theme ?? this.theme,
      themes: themes ?? this.themes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        theme,
        themes,
      ];
}
