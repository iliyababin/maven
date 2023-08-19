part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeInitialize extends ThemeEvent {
  const ThemeInitialize();

  @override
  List<Object?> get props => [];
}

class ThemeAdd extends ThemeEvent {
  const ThemeAdd({
    required this.theme,
  });

  final AppTheme theme;

  @override
  List<Object?> get props => [
        theme,
      ];
}

class ThemeUpdate extends ThemeEvent {
  const ThemeUpdate({
    required this.theme,
  });

  final AppTheme theme;

  @override
  List<Object?> get props => [
        theme,
      ];
}

class ThemeDelete extends ThemeEvent {
  const ThemeDelete({
    required this.theme,
  });

  final AppTheme theme;

  @override
  List<Object?> get props => [
        theme,
      ];
}

class ThemeChange extends ThemeEvent {
  const ThemeChange({
    required this.theme,
  });

  final AppTheme theme;

  @override
  List<Object?> get props => [
    theme,
  ];
}
