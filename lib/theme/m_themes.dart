import 'package:flutter/cupertino.dart';
import 'package:theme_provider/theme_provider.dart';

import 'm_theme_scheme.dart';

MavenThemeOptions mt(BuildContext context){
  return ThemeProvider.optionsOf<MavenThemeOptions>(context);
}