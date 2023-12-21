import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maven/database/converter/converter.dart';

void main() {
  group('LocaleConverter', () {
    test('should convert from Locale to String', () {
      // arrange
      const tLocale = Locale('en', 'US');
      const tString = 'en_US';
      // act
      final result = LocaleConverter().encode(tLocale);
      // assert
      expect(result, tString);
    });

    test('should convert from String to Locale', () {
      // arrange
      const tLocale = Locale('en', 'US');
      const tString = 'en_US';
      // act
      final result = LocaleConverter().decode(tString);
      // assert
      expect(result, tLocale);
    });
  });
}
