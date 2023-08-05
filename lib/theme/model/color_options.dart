import 'package:floor/floor.dart';
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
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.inversePrimary,
    required this.inverseSurface,
    required this.onInverseSurface,
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

  @ColumnInfo(name: 'primary')
  final Color primary;

  @ColumnInfo(name: 'on_primary')
  final Color onPrimary;

  @ColumnInfo(name: 'primary_container')
  final Color primaryContainer;

  @ColumnInfo(name: 'on_primary_container')
  final Color onPrimaryContainer;

  @ColumnInfo(name: 'secondary')
  final Color secondary;

  @ColumnInfo(name: 'on_secondary')
  final Color onSecondary;

  @ColumnInfo(name: 'secondary_container')
  final Color secondaryContainer;

  @ColumnInfo(name: 'on_secondary_container')
  final Color onSecondaryContainer;

  @ColumnInfo(name: 'background')
  final Color background;

  @ColumnInfo(name: 'on_background')
  final Color onBackground;

  @ColumnInfo(name: 'surface')
  final Color surface;

  @ColumnInfo(name: 'on_surface')
  final Color onSurface;

  @ColumnInfo(name: 'on_surface_variant')
  final Color onSurfaceVariant;

  @ColumnInfo(name: 'outline')
  final Color outline;

  @ColumnInfo(name: 'outline_variant')
  final Color outlineVariant;

  @ColumnInfo(name: 'inverse_primary')
  final Color inversePrimary;

  @ColumnInfo(name: 'inverse_surface')
  final Color inverseSurface;

  @ColumnInfo(name: 'on_inverse_surface')
  final Color onInverseSurface;

  @ColumnInfo(name: 'success')
  final Color success;

  @ColumnInfo(name: 'on_success')
  final Color onSuccess;

  @ColumnInfo(name: 'success_container')
  final Color successContainer;

  @ColumnInfo(name: 'on_success_container')
  final Color onSuccessContainer;

  @ColumnInfo(name: 'error')
  final Color error;

  @ColumnInfo(name: 'on_error')
  final Color onError;

  @ColumnInfo(name: 'error_container')
  final Color errorContainer;

  @ColumnInfo(name: 'on_error_container')
  final Color onErrorContainer;

  @ColumnInfo(name: 'shadow')
  final Color shadow;

  @ColumnInfo(name: 'warmup')
  final Color warmup;

  @ColumnInfo(name: 'drop')
  final Color drop;

  @ColumnInfo(name: 'cooldown')
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
        'inversePrimary': inversePrimary,
        'inverseSurface': inverseSurface,
        'onInverseSurface': onInverseSurface,
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

  ColorOptions setColors(Map<String, Color> map) {
    return ColorOptions(
      primary: map['primary'] ?? primary,
      onPrimary: map['onPrimary'] ?? onPrimary,
      primaryContainer: map['primaryContainer'] ?? primaryContainer,
      onPrimaryContainer: map['onPrimaryContainer'] ?? onPrimaryContainer,
      secondary: map['secondary'] ?? secondary,
      onSecondary: map['onSecondary'] ?? onSecondary,
      secondaryContainer: map['secondaryContainer'] ?? secondaryContainer,
      onSecondaryContainer: map['onSecondaryContainer'] ?? onSecondaryContainer,
      background: map['background'] ?? background,
      onBackground: map['onBackground'] ?? onBackground,
      surface: map['surface'] ?? surface,
      onSurface: map['onSurface'] ?? onSurface,
      onSurfaceVariant: map['onSurfaceVariant'] ?? onSurfaceVariant,
      outline: map['outline'] ?? outline,
      outlineVariant: map['outlineVariant'] ?? outlineVariant,
      inversePrimary: map['inversePrimary'] ?? inversePrimary,
      inverseSurface: map['inverseSurface'] ?? inverseSurface,
      onInverseSurface: map['onInverseSurface'] ?? onInverseSurface,
      success: map['success'] ?? success,
      onSuccess: map['onSuccess'] ?? onSuccess,
      successContainer: map['successContainer'] ?? successContainer,
      onSuccessContainer: map['onSuccessContainer'] ?? onSuccessContainer,
      error: map['error'] ?? error,
      onError: map['onError'] ?? onError,
      errorContainer: map['errorContainer'] ?? errorContainer,
      onErrorContainer: map['onErrorContainer'] ?? onErrorContainer,
      shadow: map['shadow'] ?? shadow,
      warmup: map['warmup'] ?? warmup,
      drop: map['drop'] ?? drop,
      cooldown: map['cooldown'] ?? cooldown,
    );
  }
}
