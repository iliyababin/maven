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
    required this.options,
  });

  final int id;
  final String name;
  final String path;
  final ThemeOptions options;

  ThemeData get data {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,

        primary: options.color.primary,
        onPrimary: options.color.onPrimary,
        primaryContainer: options.color.primaryContainer,
        onPrimaryContainer: options.color.onPrimaryContainer,

        secondary: options.color.secondary,
        onSecondary: options.color.onSecondary,
        secondaryContainer: options.color.secondaryContainer,
        onSecondaryContainer: options.color.onSecondaryContainer,

        error: options.color.error,
        onError: options.color.text,

        background: options.color.background,
        onBackground: options.color.text,

        surface: options.color.background,
        onSurface: options.color.text,
        outline: options.color.secondary,

        onTertiary: Colors.green,
        onTertiaryContainer: Colors.green,
        tertiary: Colors.green,
        tertiaryContainer: Colors.green,

        surfaceTint: Colors.yellow,
        errorContainer: Colors.purple,
        inversePrimary: Colors.red,
        inverseSurface: Colors.red,
        onErrorContainer: Colors.red,
        onInverseSurface: Colors.red,

        onSurfaceVariant: Colors.red,

        // A utility color that creates boundaries for decorative elements when a 3:1 contrast isn’t required, such as for dividers or decorative elements.
        outlineVariant: Colors.purple,
        scrim: Colors.green,
        shadow: Colors.red,

        surfaceVariant: Colors.green,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 44),
          ),
          textStyle: MaterialStateProperty.all(
            options.textStyle.button1,
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
          textStyle: MaterialStateProperty.all(
            options.textStyle.body1,
          ),
          backgroundColor: MaterialStateProperty.all(
            options.color.secondary,
          ),
          minimumSize: MaterialStateProperty.all(
            Size(46, 44),
          ),
          foregroundColor: MaterialStateProperty.all(
            options.color.onSecondary,
          ),
          iconColor: MaterialStateProperty.all(
            options.color.onSecondary,
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
        foregroundColor: options.color.text,
        iconTheme: IconThemeData(
          color: options.color.primary,
        ),
      ),

      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: options.textStyle.body1,
        labelStyle: options.textStyle.body1,
        labelColor: options.color.text,
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
        unselectedItemColor: options.color.subtext,
        type: BottomNavigationBarType.fixed,
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
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.only(left: 20),
        iconColor: options.color.primary,
        textColor: options.color.text,
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
          color: options.color.subtext,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: options.color.secondary,
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: options.color.primary,
        foregroundColor: options.color.background,
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
        text: Color(0xff282828),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF2DCD70),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFC1C1C1),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );

  static const AppTheme dark = AppTheme(
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
  );

  static const AppTheme solarFlare = AppTheme(
    id: 3,
    name: 'Solar flare',
    path: 'assets/images/solar_flare.jpg',
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFFFFAE00),
        onPrimary: Color(0xff121212),
        primaryContainer: Color(0xFF463C26),
        onPrimaryContainer: Color(0xFFFFB939),

        secondary: Color(0xFF2A2A2A),
        onSecondary: Color(0xFFFFBC2E),
        secondaryContainer: Color(0xFF282828),
        onSecondaryContainer: Color(0xFFEFEFEF),

        background: Color(0xff232323),
        text: Color(0xffffffff),
        subtext: Color(0xFF808080),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF922DCD),
        error: Color(0xFFDD614A),
        shadow: Color(0xFF353535),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );

  static const AppTheme nature = AppTheme(
    id: 4,
    name: 'Nature',
    path: 'assets/images/nature.jpg',
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFF4CAF50),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xFF94f990),
        onPrimaryContainer: Color(0xFF002204),
        secondary: Color(0xffd6ecd2),
        onSecondary: Color(0xFF4CAF50),
        secondaryContainer: Color(0xFFd5e8cf),
        onSecondaryContainer: Color(0xFF111f0f),
        background: Color(0xFFE8F5E9),
        text: Color(0xFF212121),
        subtext: Color(0xFF757575),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFF4CAF50),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFBDBDBD),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );

/*
  static const AppTheme roseGold = AppTheme(
    id: 5,
    name: 'Rose Gold',
    path: 'assets/images/rose_gold.jpg',
    options: ThemeOptions(
      color: ColorOptions(
        primary: Color(0xFFE91E63),
        secondary: Color(0xFFE91E63),
        background: Color(0xFFFAF0E6),
        text: Color(0xFF212121),
        subtext: Color(0xFF757575),
        neutral: Color(0xFFFFFFFF),
        success: Color(0xFFAF4C4C),
        error: Color(0xFFDD614A),
        shadow: Color(0xFFBDBDBD),
        warmup: Color(0xFFFFAE00),
        drop: Color(0xFFBD4ADD),
        cooldown: Color(0xFF21F3F3),
      ),
    ),
  );
*/
  static const List<AppTheme> themes = [
    light,
    dark,
    solarFlare,
    nature,
    /*nature,
    roseGold,*/
  ];
}
