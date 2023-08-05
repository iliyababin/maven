import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'theme_options.dart';

/// A theme that can be applied to the app.
class AppTheme extends Equatable {
  const AppTheme({
    this.id,
    required this.name,
    required this.path,
    required this.brightness,
    required this.options,
  });

  final int? id;
  final String name;
  final String path;
  final Brightness brightness;
  final ThemeOptions options;

  ThemeData get data {
    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        headlineLarge: options.textStyle.headingLarge,
        headlineMedium: options.textStyle.headingMedium,
        titleLarge: options.textStyle.titleLarge,
        titleMedium: options.textStyle.titleMedium,
        titleSmall: options.textStyle.titleSmall,
        bodyLarge: options.textStyle.bodyLarge,
        bodyMedium: options.textStyle.bodyMedium,
        labelLarge: options.textStyle.labelLarge,
        labelMedium: options.textStyle.labelMedium,
        labelSmall: options.textStyle.labelSmall,
      ),
      splashFactory: InkSparkle.splashFactory,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: options.color.primary,
        onPrimary: options.color.onPrimary,
        primaryContainer: options.color.primaryContainer,
        onPrimaryContainer: options.color.onPrimaryContainer,

        secondary: options.color.secondary,
        onSecondary: options.color.onSecondary,
        secondaryContainer: options.color.secondaryContainer,
        onSecondaryContainer: options.color.onSecondaryContainer,

        error: options.color.error,
        onError: options.color.onBackground,
        errorContainer: Colors.purple,
        onErrorContainer: Colors.purple,

        background: options.color.background,
        onBackground: options.color.onBackground,

        outline: options.color.outline,
        outlineVariant: options.color.outlineVariant,

        surface: options.color.background,
        onSurface: options.color.onBackground,
        surfaceTint: options.color.background,

        inversePrimary: options.color.inversePrimary,
        inverseSurface: options.color.inverseSurface,
        onInverseSurface: options.color.onInverseSurface,

        onTertiary: Colors.yellow,
        onTertiaryContainer: Colors.yellow,
        tertiary: Colors.yellow,
        tertiaryContainer: Colors.yellow,

/*
        onSurfaceVariant: Color(0xff424940),
*/
        // A utility color that creates boundaries for decorative elements when a 3:1 contrast isn’t required, such as for dividers or decorative elements.
        scrim: Colors.red,
        shadow: options.color.shadow,
        surfaceVariant: options.color.outlineVariant,
      ),
      typography: Typography.material2021(),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(options.shape.medium),
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 44),
          ),
          foregroundColor: MaterialStateProperty.all(
            options.color.onPrimary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(46, 44),
          ),
          foregroundColor: MaterialStateProperty.all(
            options.color.onBackground,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),



      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: options.color.background,
        foregroundColor: options.color.onBackground,
        iconTheme: IconThemeData(
          color: options.color.primary,
        ),
      ),

      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: options.textStyle.bodyLarge,
        labelStyle: options.textStyle.bodyLarge,
        labelColor: options.color.onBackground,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: options.color.primary,
            width: 2,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: options.color.primary,
        size: 24,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.only(left: 24, right: 24),
        iconColor: options.color.primary,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              fontWeight: FontWeight.bold,
            );
          } else {
            return TextStyle();
          }
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return options.color.primary;
          } else {
            return options.color.secondary;
          }
        }),
        checkColor: MaterialStateProperty.all(options.color.background),
      ),
      /*inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: options.color.onSurfaceVariant,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: options.color.outline,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: options.color.primary,
            width: 2,
          ),
        ),
      ),*/
    );
  }

  AppTheme copyWith({
    int? id,
    String? name,
    String? path,
    Brightness? brightness,
    ThemeOptions? options,
  }) {
    return AppTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      brightness: brightness ?? this.brightness,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        path,
        options,
      ];
}
