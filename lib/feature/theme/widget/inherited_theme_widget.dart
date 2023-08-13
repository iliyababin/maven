import 'package:flutter/material.dart';

import '../theme.dart';

class InheritedThemeWidget extends InheritedWidget {
  const InheritedThemeWidget({
    super.key,
    required super.child,
    required AppTheme theme,
  })  : _theme = theme;

  final AppTheme _theme;

  AppTheme get theme => _theme;

  static InheritedThemeWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedThemeWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedThemeWidget oldWidget) {
    return _theme != oldWidget.theme;
  }
}