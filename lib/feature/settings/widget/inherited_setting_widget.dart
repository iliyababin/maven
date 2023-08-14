import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../settings.dart';

class InheritedSettingWidget extends InheritedWidget {
  const InheritedSettingWidget({
    super.key,
    required Setting setting,
    required Widget child,
  })  : _setting = setting,
        super(child: child);

  final Setting _setting;

  Setting get setting => _setting;

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
