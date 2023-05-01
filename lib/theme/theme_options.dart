import 'dart:ui';

import 'package:Maven/theme/padding_theme.dart';
import 'package:Maven/theme/text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'color_theme.dart';


class ThemeOptions implements AppThemeOptions  {
  ThemeOptions({
    required Color primary,
    required Color secondary,
    required Color background,
    required Color text,
    required Color subtext,
    required Color neutral,
    required Color success,
    required Color error,
    required Color shadow,
  }) {
    color = ColorTheme(
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
    );
    textStyle = TextStyleTheme(
      heading1: text,
      heading2: text,
      heading3: text,
      body1: text,
      subtitle1: subtext,
      subtitle2: primary,
      button1: neutral,
      button2: primary,
    );
    padding = const PaddingTheme(
      page: 20,
    );
  }

  late final ColorTheme color;
  late final TextStyleTheme textStyle;
  late final PaddingTheme padding;
}

