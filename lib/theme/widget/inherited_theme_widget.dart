import 'package:maven/theme/model/theme_options.dart';
import 'package:flutter/material.dart';

import '../model/app_theme.dart';

class InheritedThemeWidget extends InheritedWidget {
  final AppTheme _theme;
  final Function(int themeId) _setTheme;

  AppTheme get theme => _theme;
  Function(int themeId) get setTheme => _setTheme;

  const InheritedThemeWidget({super.key,
    required AppTheme theme,
    required Function(int themeId) setTheme,
    required Widget child,
  }) :  _theme = theme,
        _setTheme = setTheme,
        super(child: child);

  static InheritedThemeWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedThemeWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedThemeWidget oldWidget) {
    return theme != oldWidget.theme  || setTheme != oldWidget.setTheme;
  }
}

ThemeOptions T(BuildContext context) => InheritedThemeWidget.of(context).theme.options;