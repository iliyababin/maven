

import '../theme.dart';

class AppThemeOption {
  const AppThemeOption({
    required AppThemeColor color,
  }) : _colorOptions = color;

  const AppThemeOption.empty()
      : _colorOptions = const AppThemeColor.dark();

  final AppThemeColor _colorOptions;

  AppThemeColor get color {
    return _colorOptions;
  }

  AppThemeTextStyle get textStyle {
    return const AppThemeTextStyle();
  }

  AppThemeSpacer get space {
    return const AppThemeSpacer(
      large: 18,
      medium: 12,
      small: 6,
    );
  }

  AppThemeShape get shape {
    return const AppThemeShape(
      large: 16,
      medium: 8,
      small: 4,
    );
  }

}
