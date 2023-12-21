import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../settings.dart';

class SettingsProvider extends StatefulWidget {
  const SettingsProvider({
    Key? key,
    required this.settings,
    required this.child,
  }) : super(key: key);

  final Settings settings;
  final Widget child;

  @override
  State<SettingsProvider> createState() => _SettingsProviderState();
}

class _SettingsProviderState extends State<SettingsProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InheritedSettingsWidget(
          settings: state.settings!,
          child: widget.child,
        );
      },
    );
  }
}
