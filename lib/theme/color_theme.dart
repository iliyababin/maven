import 'package:flutter/material.dart';

class ColorTheme {
  ColorTheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.subtext,
    required this.neutral,
    required this.success,
    required this.error,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color subtext;
  final Color neutral;
  final Color success;
  final Color error;
}