import 'package:flutter/material.dart';
import 'package:maven/data/app_colors.dart';
import 'package:theme_provider/theme_provider.dart';

import '../maven.dart';

List<AppTheme> getThemes(){
  return [
    AppTheme(
      id: "light_theme",
      description: "My Custom Theme",
      data: ThemeData(),
      options: AppColors(
        backgroundColor: const Color(0xFFFFFFFF),
        backgroundLightColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFF2196F3),
        primaryTextColor: const Color(0xFF000000),
        accentTextColor: const Color(0xFF2196F3),
        textFieldBackgroundColor: const Color(0xFFE8E8E8),
        textFieldHintColor: const Color(0xFFC8C8C8),
        completeColor: const Color(0xFFC1FFB0),
        checkColor: const Color(0xFF2196F3),
        errorColor: const Color(0xFFFF7474),
      ),
    ),
    AppTheme(
      id: "dark_theme",
      description: "My Custom Theme",
      data: ThemeData(),
      options: AppColors(
        backgroundColor: const Color(0xff121212),
        backgroundLightColor: const Color(0xff1c1c1c),
        primaryColor: const Color(0xFF2196F3),
        primaryTextColor: const Color(0xFFFFFFFF),
        accentTextColor: const Color(0xFF2196F3),
        textFieldBackgroundColor: const Color(0xff232323),
        textFieldHintColor: const Color(0xff434343),
        completeColor: const Color(0xFF173515),
        checkColor: const Color(0xFF2196F3),
        errorColor: const Color(0xFFF32121),
      ),
    ),
  ];
}

AppColors colors(BuildContext context){
  return ThemeProvider.optionsOf<AppColors>(context);
}

