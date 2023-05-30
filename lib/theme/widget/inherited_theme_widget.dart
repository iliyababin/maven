import 'package:flutter/material.dart';

import '../model/app_theme.dart';
import '../model/theme_options.dart';

class InheritedThemeWidget extends InheritedWidget {
  const InheritedThemeWidget({
    super.key,
    required AppTheme theme,
    required Function(int themeId) setTheme,
    required Widget child,
  })  : _theme = theme,
        _setTheme = setTheme,
        super(child: child);

  final AppTheme _theme;
  final Function(int themeId) _setTheme;

  AppTheme get theme => _theme;
  Function(int themeId) get setTheme => _setTheme;

  static InheritedThemeWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedThemeWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedThemeWidget oldWidget) {
    return theme != oldWidget.theme || setTheme != oldWidget.setTheme;
  }
}

/// Returns the [ThemeOptions] of the closest [InheritedThemeWidget] ancestor.
ThemeOptions T(BuildContext context) => InheritedThemeWidget.of(context).theme.options;
