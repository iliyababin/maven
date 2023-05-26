import 'dart:ui';

import 'package:Maven/theme/padding_theme.dart';
import 'package:Maven/theme/text_style_theme.dart';
import 'package:flutter/material.dart';

import 'color_theme.dart';


class ThemeOptions {
  const ThemeOptions({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.subtext,
    required this.neutral,
    required this.success,
    required this.error,
    required this.shadow,
    required this.warmup,
    required this.drop,
    required this.cooldown,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color subtext;
  final Color neutral;
  final Color success;
  final Color error;
  final Color shadow;
  final Color warmup;
  final Color drop;
  final Color cooldown;


  ColorTheme get color {
    return ColorTheme(
      primary: primary,
      secondary: secondary,
      background:
      background,
      text: text,
      subtext: subtext,
      neutral: neutral,
      success: success,
      error: error,
      shadow: shadow,
      warmup: warmup,
      drop: drop,
      cooldown: cooldown,
    );
  }

  TextStyleTheme get textStyle {
    return TextStyleTheme(
      heading1: text,
      heading2: text,
      heading3: text,
      heading4: text,
      body1: text,
      subtitle1: subtext,
      subtitle2: primary,
      button1: neutral,
      button2: primary,
    );
  }

  PaddingTheme get padding {
    return const PaddingTheme(
      page: 20,
    );
  }
}

