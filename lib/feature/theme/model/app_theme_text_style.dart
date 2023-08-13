import 'package:flutter/material.dart';

class AppThemeTextStyle {
  const AppThemeTextStyle()
      : headingLarge = const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
        headingMedium = const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
        titleLarge = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        titleMedium = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge = const TextStyle(
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelLarge = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        labelMedium = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelSmall = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );

  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle labelSmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;

  Map<String, TextStyle> get textStyles => {
        'Heading Large': headingLarge,
        'Heading Medium': headingMedium,
        'Title Large': titleLarge,
        'Title Medium': titleMedium,
        'Title Small': titleSmall,
        'Body Large': bodyLarge,
        'Body Medium': bodyMedium,
        'Label Large': labelLarge,
        'Label Medium': labelMedium,
        'Label Small': labelSmall,
      };
}
