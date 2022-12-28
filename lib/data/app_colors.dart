import 'dart:ui';

import 'package:theme_provider/theme_provider.dart';

class AppColors implements AppThemeOptions{
  final Color backgroundColor;
  final Color backgroundDarkColor;
  final Color primaryColor;
  final Color primaryTextColor;
  final Color accentTextColor;
  final Color textFieldBackgroundColor;
  final Color textFieldHintColor;
  final Color completeColor;
  final Color checkColor;
  final Color errorColor;
  final Color unselectedItemColor;
  final Color dragBarColor;
  final Color slidingPanelShadowColor;
  final Color whiteColor;
  final Color transparentColor = const Color(0x00000000);

  AppColors({
    required this.backgroundColor,
    required this.backgroundDarkColor,
    required this.primaryColor,
    required this.primaryTextColor,
    required this.accentTextColor,
    required this.textFieldBackgroundColor,
    required this.textFieldHintColor,
    required this.completeColor,
    required this.checkColor,
    required this.errorColor,
    required this.unselectedItemColor,
    required this.dragBarColor,
    required this.slidingPanelShadowColor,
    required this.whiteColor,
  });
}