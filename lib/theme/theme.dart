import 'package:flutter/material.dart';

import '../feature/settings/settings.dart';
import 'model/theme_options.dart';

export 'model/app_theme.dart';
export 'model/color_options.dart';
export 'model/theme_options.dart';
export 'screen/theme_edit_screen.dart';
export 'screen/theme_screen.dart';
export 'widget/theme_provider.dart';

/// Returns the [ThemeOptions] of the closest [InheritedSettingWidget] ancestor.
ThemeOptions T(BuildContext context) => InheritedSettingWidget.of(context).setting.theme.options;
