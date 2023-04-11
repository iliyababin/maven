import 'package:flutter/material.dart';

class TextStyleTheme {
  TextStyleTheme({
    required Color heading1,
    required Color heading2,
    required Color body1,
    required Color body2,
    required Color subtitle1,
    required Color subtitle2,
  }) {
    this.heading1 = TextStyle(
      color: heading1,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    this.heading2 = TextStyle(
      color: heading2,
      fontSize: 19,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    );
    this.body1 = TextStyle(
      color: body1,
      fontSize: 15,
      overflow: TextOverflow.ellipsis,
    );
    this.body2 = TextStyle(
      color: body2,
      fontSize: 15,
      overflow: TextOverflow.ellipsis,
    );
    this.subtitle1 = TextStyle(
      color: subtitle1,
      fontSize: 14,
    );
    this.subtitle2 = TextStyle(
      color: subtitle2,
      fontSize: 15,
      fontWeight: FontWeight.w500
    );
  }

  late final TextStyle heading1;
  late final TextStyle heading2;
  late final TextStyle body1;
  late final TextStyle body2;
  late final TextStyle subtitle1;
  late final TextStyle subtitle2;
}