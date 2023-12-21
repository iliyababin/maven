import 'package:flutter/material.dart';

import '../../../database/database.dart';

class InheritedSettingsWidget extends InheritedWidget {
  const InheritedSettingsWidget({
    super.key,
    required Settings settings,
    required Widget child,
  })  : _settings = settings,
        super(child: child);

  final Settings _settings;

  Settings get settings => _settings;

  static InheritedSettingsWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettingsWidget>()!;
  }

  @override
  bool updateShouldNotify(InheritedSettingsWidget oldWidget) {
    return settings != oldWidget.settings;
  }
}

// Returns the [Setting] of the closest [InheritedSettingWidget] ancestor.
Settings s(BuildContext context) => InheritedSettingsWidget.of(context).settings;
