import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme.dart';

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return InheritedThemeWidget(
          theme: state.theme,
          child: widget.child,
        );
      },
    );
  }
}
