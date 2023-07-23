import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database.dart';
import '../../feature/setting/setting.dart';
import '../model/app_theme.dart';
import 'inherited_setting_widget.dart';

/// A widget that provides a theme to descendant widgets.
///
/// Example:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return ThemeProvider(
///     theme: AppTheme.dark,
///     themes: AppTheme.themes,
///     child: const App(),
///   );
/// }
/// ```
class ThemeProvider extends StatefulWidget {
  /// Create a [ThemeProvider] widget.
  const ThemeProvider({
    Key? key,
    required this.setting,
    required this.child,
  }) : super(key: key);

  /// The setting to be used.
  final Setting setting;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  late Setting _setting;

  @override
  void initState() {
    _setting = widget.setting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedSettingWidget(
      setting: _setting,
      unit: (Unit unit) {
        setState(() {
          _setting = _setting.copyWith(unit: unit);
        });
        context.read<SettingBloc>().add(SettingChangeUnits(unit: unit));
      },
      setSessionWeeklyGoal: (goal) {
        setState(() {
          _setting = _setting.copyWith(sessionWeeklyGoal: goal);
        });
        context.read<SettingBloc>().add(SettingUpdate(
          setting: _setting.copyWith(sessionWeeklyGoal: goal),
        ));
      },
      setTheme: (int id) {
        for (AppTheme element in _setting.themes) {
          if (element.id == id) {
            setState(() {
              _setting = _setting.copyWith(theme: element);
            });
            context.read<SettingBloc>().add(SettingChangeTheme(id: id));
          }
        }
      },
      child: widget.child,
    );
  }
}
