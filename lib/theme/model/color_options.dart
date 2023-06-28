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
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.outline,
    required this.outlineVariant,
    required this.onSurfaceVariant,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
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
  final Color onBackground;

  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;

  final Color outline;
  final Color outlineVariant;

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

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
        'onBackground': onBackground,
        'surface': surface,
        'onSurface': onSurface,
        'onSurfaceVariant': onSurfaceVariant,
        'outline': outline,
        'outlineVariant': outlineVariant,
        'success': success,
        'onSuccess': onSuccess,
        'successContainer': successContainer,
        'onSuccessContainer': onSuccessContainer,
        'error': error,
        'onError': onError,
        'errorContainer': errorContainer,
        'onErrorContainer': onErrorContainer,
        'shadow': shadow,
        'warmup': warmup,
        'drop': drop,
        'cooldown': cooldown,
      };
}
