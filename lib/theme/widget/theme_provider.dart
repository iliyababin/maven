import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/setting/bloc/setting_bloc.dart';
import '../model/app_theme.dart';
import 'inherited_theme_widget.dart';

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
    required this.child,
    required this.theme,
    required this.themes,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// The theme to be used.
  final AppTheme theme;

  /// The list of themes which can be used.
  final List<AppTheme> themes;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  late AppTheme _theme;

  @override
  void initState() {
    _theme = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedThemeWidget(
      theme: _theme,
      setTheme: (int id) {
        for (AppTheme element in widget.themes) {
          if (element.id == id) {
            setState(() {
              _theme = element;
            });
            context.read<SettingBloc>().add(SettingChangeTheme(id: id));
          }
        }
      },
      child: widget.child,
    );
  }
}
