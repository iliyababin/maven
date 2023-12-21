import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

class LocaleConverter extends TypeConverter<Locale, String> {
  @override
  Locale decode(String databaseValue) {
    return Locale.fromSubtags(
      languageCode: databaseValue.split('_')[0],
      countryCode: databaseValue.split('_')[1],
    );
  }

  @override
  String encode(Locale value) {
    return value.toString();
  }
}
