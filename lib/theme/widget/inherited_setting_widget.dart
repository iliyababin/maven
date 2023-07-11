import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../feature/setting/setting.dart';
import '../model/theme_options.dart';

class InheritedSettingWidget extends InheritedWidget {
  const InheritedSettingWidget({
    super.key,
    required Setting setting,
    required Function(int themeId) setTheme,
    required Function(Unit unit) unit,
    required Widget child,
  })  : _setting = setting,
        _setTheme = setTheme,
        _setUnit = unit,
        super(child: child);

  final Setting _setting;
  final Function(int themeId) _setTheme;
  final Function(Unit unit) _setUnit;

  Setting get setting => _setting;
  Function(int themeId) get setTheme => _setTheme;
  Function(Unit unit) get setUnit => _setUnit;

  static InheritedSettingWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettingWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedSettingWidget oldWidget) {
    return setTheme != oldWidget.setTheme || setting != oldWidget.setting;
  }
}

/// Returns the [ThemeOptions] of the closest [InheritedSettingWidget] ancestor.
ThemeOptions T(BuildContext context) => InheritedSettingWidget.of(context).setting.theme.options;

// Returns the [Setting] of the closest [InheritedSettingWidget] ancestor.
Setting s(BuildContext context) => InheritedSettingWidget.of(context).setting;
