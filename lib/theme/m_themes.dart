import 'package:flutter/cupertino.dart';
import 'package:theme_provider/theme_provider.dart';

import 'theme_options.dart';

ThemeOptions mt(BuildContext context){
  return ThemeProvider.optionsOf<ThemeOptions>(context);
}