import 'package:flutter/material.dart';

import '../model/app_theme.dart';
import 'inherited_theme_widget.dart';

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({Key? key,
    required this.child,
    required this.theme,
    required this.themes,
  }) : super(key: key);

  final Widget child;
  final AppTheme theme;
  final List<AppTheme> themes;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  AppTheme theme = AppTheme.dark;

  @override
  Widget build(BuildContext context) {
    return InheritedThemeWidget(
      theme: theme,
      setTheme: (int id) {
        for (AppTheme element in widget.themes) {
          if(element.id == id) {
            setState(() {
              theme = element;
            });
          }
        }
      },
      child: widget.child,
    );
  }
}
