import 'package:maven/theme/widget/inherited_theme_widget.dart';
import 'package:flutter/material.dart';

import '../model/app_theme.dart' as app;

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({Key? key,
    required this.child,
    required this.theme,
    required this.themes,
  }) : super(key: key);

  final Widget child;
  final app.AppTheme theme;
  final List<app.AppTheme> themes;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  app.AppTheme theme = app.AppTheme.dark;

  @override
  Widget build(BuildContext context) {
    return InheritedThemeWidget(
      theme: theme,
      setTheme: (int id) {
        for (app.AppTheme element in widget.themes) {
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
