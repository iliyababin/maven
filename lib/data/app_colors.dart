import 'dart:ui';

import 'package:theme_provider/theme_provider.dart';

class AppColors implements AppThemeOptions{
  final Color backgroundColor;
  final Color backgroundLightColor;
  final Color primaryColor;
  final Color primaryTextColor;
  final Color accentTextColor;
  final Color textFieldBackgroundColor;
  final Color textFieldHintColor;
  final Color completeColor;
  final Color checkColor;
  final Color errorColor;

  AppColors({
    required this.backgroundColor,
    required this.backgroundLightColor,
    required this.primaryColor,
    required this.primaryTextColor,
    required this.accentTextColor,
    required this.textFieldBackgroundColor,
    required this.textFieldHintColor,
    required this.completeColor,
    required this.checkColor,
    required this.errorColor,
  });
}