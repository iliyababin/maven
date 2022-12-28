import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'app_colors.dart';

List<AppTheme> getThemes(BuildContext context){
  return [
    AppTheme(
      id: "light_theme",
      description: "My Custom Theme",
      data: ThemeData(),
      options: AppColors(
        backgroundColor: const Color(0xFFFFFFFF),
        backgroundDarkColor: const Color(0xFFF1F1F1),
        primaryColor: const Color(0xFF2196F3),
        primaryTextColor: const Color(0xFF000000),
        accentTextColor: const Color(0xFF2196F3),
        textFieldBackgroundColor: const Color(0xFFE8E8E8),
        textFieldHintColor: const Color(0xFFC8C8C8),
        completeColor: const Color(0xffd9ffe7),
        checkColor: const Color(0xFF2196F3),
        errorColor: const Color(0xFFDD614A),
        unselectedItemColor: const Color(0xFF595959),
        dragBarColor: const Color(0xFFCECECE),
        slidingPanelShadowColor: const Color(0xFF838383),
        whiteColor: const Color(0xFFFFFFFF),
      ),
    ),
    AppTheme(
      id: "dark_theme",
      description: "My Custom Themse",
      data: ThemeData(),
      options: AppColors(
        backgroundColor: const Color(0xff121212),
        backgroundDarkColor: const Color(0xff101010),
        primaryColor: const Color(0xFF2196F3),
        primaryTextColor: const Color(0xFFFFFFFF),
        accentTextColor: const Color(0xFF2196F3),
        textFieldBackgroundColor: const Color(0xff232323),
        textFieldHintColor: const Color(0xff434343),
        completeColor: const Color(0xFF4CAF50),
        checkColor: const Color(0xFF2196F3),
        errorColor: const Color(0xFFDD614A),
        unselectedItemColor: const Color(0xFFB7B7B7),
        dragBarColor: const Color(0xFF383838),
        slidingPanelShadowColor: const Color(0xFF000000),
        whiteColor: const Color(0xFFFFFFFF),
      ),
    ),
  ];
}

AppColors colors(BuildContext context){
  return ThemeProvider.optionsOf<AppColors>(context);
}

