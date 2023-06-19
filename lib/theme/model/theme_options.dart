import 'color_options.dart';
import 'padding_options.dart';
import 'text_style_options.dart';

class ThemeOptions {
  const ThemeOptions({
    required ColorOptions color,
  }) : _colorOptions = color;

  final ColorOptions _colorOptions;

  ColorOptions get color {
    return ColorOptions(
      primary: _colorOptions.primary,
      onPrimary: _colorOptions.onPrimary,
      primaryContainer: _colorOptions.primaryContainer,
      onPrimaryContainer: _colorOptions.onPrimaryContainer,
      secondary: _colorOptions.secondary,
      onSecondary: _colorOptions.onSecondary,
      secondaryContainer: _colorOptions.secondaryContainer,
      onSecondaryContainer: _colorOptions.onSecondaryContainer,
      background: _colorOptions.background,
      surface: _colorOptions.surface,
      onSurface: _colorOptions.onSurface,
      outline: _colorOptions.outline,
      outlineVariant: _colorOptions.outlineVariant,
      onBackground: _colorOptions.onBackground,
      subtext: _colorOptions.subtext,
      neutral: _colorOptions.neutral,
      success: _colorOptions.success,
      error: _colorOptions.error,
      shadow: _colorOptions.shadow,
      warmup: _colorOptions.warmup,
      drop: _colorOptions.drop,
      cooldown: _colorOptions.cooldown,
    );
  }

  TextStyleOptions get textStyle {
    return TextStyleOptions(
      heading1: _colorOptions.onBackground,
      heading2: _colorOptions.onBackground,
      heading3: _colorOptions.onBackground,
      heading4: _colorOptions.onBackground,
      body1: _colorOptions.onBackground,
      subtitle1: _colorOptions.subtext,
      subtitle2: _colorOptions.primary,
      button1: _colorOptions.background,
      button2: _colorOptions.primary,
    );
  }

  PaddingOptions get padding {
    return const PaddingOptions(
      page: 20,
    );
  }
}
