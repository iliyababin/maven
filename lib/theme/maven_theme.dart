import 'package:Maven/theme/theme_options.dart';
import 'package:flutter/material.dart';

class MavenTheme {
  final String id;
  final String description;
  final ThemeOptions options;

  const MavenTheme({
    required this.id,
    required this.description,
    required this.options,
  });

  ThemeData get data {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: options.color.background,
        foregroundColor: options.color.text,
        iconTheme: IconThemeData(
          color: options.color.primary,
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
      // Other theme data configurations
    );
  }

  static const MavenTheme blank = MavenTheme(
    id: 'assets/image/dark.jpg',
    description: 'Dark',
    options: ThemeOptions(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF333333),
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
  );

  static const List<MavenTheme> defaultThemes = [
    MavenTheme(
      id: 'assets/image/light.jpg',
      description: 'Light',
      options: ThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFFEAEAEA),
        background: Color(0xffffffff),
        text: Color(0xff000000),
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
    MavenTheme(
      id: 'assets/image/dark.jpg',
      description: 'Dark',
      options: ThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFF333333),
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
    MavenTheme(
      id: 'assets/image/solar_flare.jpg',
      description: 'Solar flare',
      options: ThemeOptions(
        primary: Color(0xFFFFAE00),
        secondary: Color(0xFF333333),
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
    MavenTheme(
      id: 'assets/image/nature.jpg',
      description: 'Nature',
      options: ThemeOptions(
        primary: Color(0xFF4CAF50),
        secondary: Color(0xFF8BC34A),
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
    MavenTheme(
      id: 'assets/image/rose_gold.jpg',
      description: 'Rose Gold',
      options: ThemeOptions(
        primary: Color(0xFFE91E63),
        secondary: Color(0xFFFFDF9F),
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
    MavenTheme(
      id: 'assets/image/custom.jpg',
      description: 'Custom',
      options: ThemeOptions(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFFEAEAEA),
        background: Color(0xffffffff),
        text: Color(0xff000000),
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
  ];
}



