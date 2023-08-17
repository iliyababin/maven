import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/settings.dart';
import '../theme.dart';

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    super.key,
    required this.useSystemTheme,
    required this.child,
  });

  final bool useSystemTheme;
  final Widget child;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            AppTheme theme;
            if(s(context).useDynamicColor) {
              theme = AppTheme.fromSystem(MediaQuery.of(context).platformBrightness == Brightness.light
                  ? lightDynamic ?? state.light.data.colorScheme
                  : darkDynamic ?? state.dark.data.colorScheme);
            } else if(s(context).useSystemDefaultTheme) {
              theme = MediaQuery.of(context).platformBrightness == Brightness.light
                  ? state.light
                  : state.dark;
            } else {
              theme = state.theme;
            }
            return InheritedThemeWidget(
              theme: theme,
              child: widget.child,
            );
          },
        );
      },
    );
  }
}
