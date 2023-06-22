import 'package:flutter/material.dart';

class ColorOptions {
  const ColorOptions({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.outline,
    required this.outlineVariant,
    required this.onBackground,
    required this.subtext,
    required this.neutral,
    required this.success,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.shadow,
    required this.warmup,
    required this.drop,
    required this.cooldown,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color outline;
  final Color outlineVariant;
  final Color onBackground;
  final Color subtext;
  final Color neutral;
  final Color success;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color shadow;
  final Color warmup;
  final Color drop;
  final Color cooldown;

  Map<String, Color> get colors => {
        'primary': primary,
        'onPrimary': onPrimary,
        'primaryContainer': primaryContainer,
        'onPrimaryContainer': onPrimaryContainer,
        'secondary': secondary,
        'onSecondary': onSecondary,
        'secondaryContainer': secondaryContainer,
        'onSecondaryContainer': onSecondaryContainer,
        'background': background,
        'text': onBackground,
        'subtext': subtext,
        'neutral': neutral,
        'success': success,
        'error': error,
        'shadow': shadow,
        'warmup': warmup,
        'drop': drop,
        'cooldown': cooldown,
      };
}
