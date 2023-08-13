import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../settings.dart';

class InheritedSettingWidget extends InheritedWidget {
  const InheritedSettingWidget({
    super.key,
    required Setting setting,
    required Function(Unit unit) unit,
    required Function(int goal) setSessionWeeklyGoal,
    required Widget child,
  })  : _setting = setting,
        _setUnit = unit,
        _setSessionWeeklyGoal = setSessionWeeklyGoal,
        super(child: child);

  final Setting _setting;
  final Function(Unit unit) _setUnit;
  final Function(int goal) _setSessionWeeklyGoal;

  Setting get setting => _setting;
  Function(Unit unit) get setUnit => _setUnit;
  Function(int goal) get setSessionWeeklyGoal => _setSessionWeeklyGoal;

  static InheritedSettingWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettingWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedSettingWidget oldWidget) {
    return  setting != oldWidget.setting;
  }
}


// Returns the [Setting] of the closest [InheritedSettingWidget] ancestor.
Setting s(BuildContext context) => InheritedSettingWidget.of(context).setting;
