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
      child: widget.child,
    );
  }
}
