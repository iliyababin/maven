import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'color_options.dart';
import 'theme_options.dart';

/// A theme that can be applied to the app.
class AppTheme extends Equatable {
  const AppTheme({
    required this.id,
    required this.name,
    required this.path,
    required this.brightness,
    required this.options,
  });

  final int id;
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

        onTertiary: Colors.yellow,
        onTertiaryContainer: Colors.yellow,
        tertiary: Colors.yellow,
        tertiaryContainer: Colors.yellow,

        //TODO: Add these colors
        inversePrimary: Colors.purple,
        inverseSurface: Colors.purple,
        onInverseSurface: Colors.purple,
/*
        onSurfaceVariant: Color(0xff424940),
*/
        // A utility color that creates boundaries for decorative elements when a 3:1 contrast isn’t required, such as for dividers or decorative elements.
        scrim: Colors.red,
        shadow: Colors.red,
        surfaceVariant: options.color.outlineVariant,
      ),
      typography: Typography.material2021(),

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

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: options.color.background,
        selectedItemColor: options.color.primary,
        unselectedItemColor: options.color.onSurface,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
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
      inputDecorationTheme: InputDecorationTheme(
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
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        path,
        options,
      ];

  static const AppTheme light = AppTheme(
    id: 1,
    name: 'Light',
    path: 'assets/images/light.jpg',
    brightness: Brightness.light,
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFF2196F3),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFDBF0FF),
        onPrimaryContainer: Color(0xFF167DD0),

        secondary: Color(0xFFEFEFEF),
        onSecondary: Color(0xFF282828),
        secondaryContainer: Color(0xFFEFEFEF),
        onSecondaryContainer: Color(0xFF282828),

        background: Color(0xffffffff),
        onBackground: Color(0xff000000),
        outline: Color(0xFFDCDCDC),
        outlineVariant: Color(0xFFB9B9B9),

        success: Color(0xFF2DCD70),
        onSuccess: Color(0xFFffffff),
        successContainer: Color(0xFFD9F5E7),
        onSuccessContainer: Color(0xFF000000),

        error: Color(0xFFDD614A),
        onError: Color(0xFFffffff),
        errorContainer: Color(0xFFffdad3),
        onErrorContainer: Color(0xFF783428),

        onSurfaceVariant: Color(0xFF808080),
        shadow: Color(0xFFC1C1C1),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),

        surface: Color(0xfff2f2f2),
        onSurface: Color(0xFF001f25),
      ),
    ),
  );

  /*static const AppTheme dark = AppTheme(
    id: 2,
    name: 'Dark',
    path: 'assets/images/dark.jpg',
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFF2196F3),
        onPrimary: Color(0xff121212),
        primaryContainer: Color(0xFF072533),
        onPrimaryContainer: Color(0xFF1685DE),

        secondary: Color(0xFF232323),
        onSecondary: Color(0xFF37A7FF),
        secondaryContainer: Color(0xFF282828),
        onSecondaryContainer: Color(0xFFEFEFEF),

        background: Color(0xff121212),
        outline: Color(0xFF5F5F5F),
        outlineVariant: Color(0xFF131313),


        text: Color(0xffffffff),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF2DCD70),
        error: Color(0xFFDD614A),
        shadow: Color(0xFF353535),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );*/

  static const AppTheme solarFlare = AppTheme(
    id: 2,
    name: 'Solar flare',
    path: 'assets/images/solar_flare.jpg',
    brightness: Brightness.dark,
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFFFFAE00),
        onPrimary: Color(0xff121212),
        primaryContainer: Color(0xFF463C26),
        onPrimaryContainer: Color(0xFFFFB939),

        secondary: Color(0xff6f6240),
        onSecondary: Color(0xffffe1aa),
        secondaryContainer: Color(0xFF56442a),
        onSecondaryContainer: Color(0xFFfadebb),

        background: Color(0xff232323),
        onBackground: Color(0xffffffff),

        surface: Color(0xFF2A2A2A),
        onSurface: Color(0xFFFFFFFF),

        outline: Color(0xFF3A3A3A),
        outlineVariant: Color(0xFF3A3A3A),

        success: Color(0xFF2DCD70),
        onSuccess: Color(0xff121212),
        successContainer: Color(0xFF155A37),
        onSuccessContainer: Color(0xFFFFFFFF),

        error: Color(0xFFa63926),
        onError: Color(0xFFffffff),
        errorContainer: Color(0xFFffdad3),
        onErrorContainer: Color(0xFF3f0300),

        onSurfaceVariant: Color(0xFFACACAC),

        shadow: Color(0xFF101010),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );

  static const AppTheme nature = AppTheme(
    id: 3,
    name: 'Nature',
    path: 'assets/images/nature.jpg',
    brightness: Brightness.light,
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFF4CAF50),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xFF94f990),
        onPrimaryContainer: Color(0xFF002204),

        secondary: Color(0xFF52634f),
        onSecondary: Color(0xFFffffff),
        secondaryContainer: Color(0xFFd5e8cf),
        onSecondaryContainer: Color(0xFF111f0f),

        background: Color(0xFFf6fff1),
        onBackground: Color(0xFF212121),

        surface: Color(0xffe8f8d7),
        onSurface: Color(0xFF141e0d),

        outline: Color(0xFFC4C8BB),
        outlineVariant: Color(0xFFC4C8BB),

        onSurfaceVariant: Color(0xFF757575),

        success: Color(0xFF2DCD70),
        onSuccess: Color(0xFFffffff),
        successContainer: Color(0xFFD9F5E7),
        onSuccessContainer: Color(0xFF000000),

        error: Color(0xFFffb4a5),
        onError: Color(0xFF650900),
        errorContainer: Color(0xFF862211),
        onErrorContainer: Color(0xFFffdad3),

        shadow: Color(0xFFBDBDBD),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );

  static const List<AppTheme> themes = [
    light,
    nature,
    solarFlare,
  ];
}
