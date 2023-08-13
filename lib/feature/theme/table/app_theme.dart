import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../model/app_theme_option.dart';

@Entity(
  tableName: 'app_theme',
  primaryKeys: [
    'id',
  ],
)
class AppTheme extends Equatable {
  const AppTheme({
    this.id,
    required this.name,
    required this.brightness,
    this.option = const AppThemeOption.empty(),
  });

  const AppTheme.empty() : this(
    name: '',
    brightness: Brightness.light,
  );

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'brightness')
  final Brightness brightness;

  @ignore
  final AppThemeOption option;

  ThemeData get data {
    return ThemeData(
      useMaterial3: true,
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: option.color.background,
        foregroundColor: option.color.onBackground,
        iconTheme: IconThemeData(
          color: option.color.primary,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return option.color.primary;
          } else {
            return option.color.secondary;
          }
        }),
        checkColor: MaterialStateProperty.all(option.color.background),
      ),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: option.color.primary,
        onPrimary: option.color.onPrimary,
        primaryContainer: option.color.primaryContainer,
        onPrimaryContainer: option.color.onPrimaryContainer,

        secondary: option.color.secondary,
        onSecondary: option.color.onSecondary,
        secondaryContainer: option.color.secondaryContainer,
        onSecondaryContainer: option.color.onSecondaryContainer,

        error: option.color.error,
        onError: option.color.onBackground,
        errorContainer: Colors.purple,
        onErrorContainer: Colors.purple,

        background: option.color.background,
        onBackground: option.color.onBackground,

        outline: option.color.outline,
        outlineVariant: option.color.outlineVariant,

        surface: option.color.background,
        onSurface: option.color.onBackground,
        surfaceTint: option.color.background,

        inversePrimary: option.color.inversePrimary,
        inverseSurface: option.color.inverseSurface,
        onInverseSurface: option.color.onInverseSurface,

        onTertiary: Colors.yellow,
        onTertiaryContainer: Colors.yellow,
        tertiary: Colors.yellow,
        tertiaryContainer: Colors.yellow,

/*
        onSurfaceVariant: Color(0xff424940),
*/
        // A utility color that creates boundaries for decorative elements when a 3:1 contrast isn’t required, such as for dividers or decorative elements.
        scrim: Colors.red,
        shadow: option.color.shadow,
        surfaceVariant: option.color.outlineVariant,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 44),
          ),
          foregroundColor: MaterialStateProperty.all(
            option.color.onPrimary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: option.color.primary,
        size: 24,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.only(left: 24, right: 24),
        iconColor: option.color.primary,
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
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(46, 44),
          ),
          foregroundColor: MaterialStateProperty.all(
            option.color.onBackground,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(option.shape.medium),
        ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: option.textStyle.bodyLarge,
        labelStyle: option.textStyle.bodyLarge,
        labelColor: option.color.onBackground,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: option.color.primary,
            width: 2,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: option.textStyle.headingLarge,
        headlineMedium: option.textStyle.headingMedium,
        titleLarge: option.textStyle.titleLarge,
        titleMedium: option.textStyle.titleMedium,
        titleSmall: option.textStyle.titleSmall,
        bodyLarge: option.textStyle.bodyLarge,
        bodyMedium: option.textStyle.bodyMedium,
        labelLarge: option.textStyle.labelLarge,
        labelMedium: option.textStyle.labelMedium,
        labelSmall: option.textStyle.labelSmall,
      ),
      typography: Typography.material2021(),
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
    Brightness? brightness,
    AppThemeOption? option,
  }) {
    return AppTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      brightness: brightness ?? this.brightness,
      option: option ?? this.option,
    );
  }

  @override
  String toString() {
    return 'AppTheme(id: $id, name: $name, brightness: $brightness, option: $option)';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brightness,
        option,
      ];
}
