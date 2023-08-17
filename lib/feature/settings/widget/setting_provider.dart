import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../settings.dart';

class SettingProvider extends StatefulWidget {
  const SettingProvider({
    Key? key,
    required this.setting,
    required this.child,
  }) : super(key: key);

  final Setting setting;
  final Widget child;

  @override
  State<SettingProvider> createState() => _SettingProviderState();
}

class _SettingProviderState extends State<SettingProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return InheritedSettingWidget(
          setting: state.setting!,
          child: widget.child,
        );
      },
    );
  }
}
