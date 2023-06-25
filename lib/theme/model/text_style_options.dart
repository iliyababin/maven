import 'package:flutter/material.dart';

class TextStyleOptions {
  TextStyleOptions()
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
        subtitle2 = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        labelLarge = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        button2 = const TextStyle(
          fontSize: 15,
        );

  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle subtitle2;
  final TextStyle labelLarge;
  final TextStyle button2;

  Map<String, TextStyle> get textStyles => {
        'Heading Large': headingLarge,
        'Heading Medium': headingMedium,
        'Title Large': titleLarge,
        'Title Medium': titleMedium,
        'Title Small': titleSmall,
        'Body Large': bodyLarge,
        'Body Medium': bodyMedium,
        'Subtitle 2': subtitle2,
        'Label Large': labelLarge,
        'Button 2': button2,
      };
}
