import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings.dart';
import 'model/model.dart';
import 'widget/inherited_theme_widget.dart';

export 'bloc/theme_bloc/theme_bloc.dart';
export 'model/model.dart';
export 'screen/screen.dart';
export 'table/table.dart';
export 'widget/widget.dart';

/// Returns the [AppThemeOption] of the closest [InheritedSettingWidget] ancestor.
AppThemeOption T(BuildContext context) => InheritedThemeWidget.of(context).theme.option;

