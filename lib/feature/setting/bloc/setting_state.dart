part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({
    this.theme = MavenTheme.blank,
    this.themes = const [MavenTheme.blank],
  });

  final MavenTheme theme;
  final List<MavenTheme> themes;

  SettingState copyWith({
    MavenTheme? theme,
    List<MavenTheme>? themes,
  }) {
    return SettingState(
      theme: theme ?? this.theme,
      themes: themes ?? this.themes,
    );
  }

  @override
  List<Object?> get props => [
    theme,
    themes,
  ];
}

