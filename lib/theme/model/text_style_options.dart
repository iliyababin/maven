import 'package:flutter/material.dart';

class TextStyleOptions {
  TextStyleOptions({
    required Color heading1,
    required Color heading2,
    required Color heading3,
    required Color heading4,
    required Color body1,
    required Color subtitle1,
    required Color subtitle2,
    required Color button1,
    required Color button2,
  })  : heading1 = TextStyle(
          color: heading1,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        heading2 = TextStyle(
          color: heading2,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        heading3 = TextStyle(
          color: heading3,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        heading4 = TextStyle(
          color: heading4,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        body1 = TextStyle(
          color: body1,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle1 = TextStyle(
          color: subtitle1,
          fontSize: 15,
        ),
        subtitle2 = TextStyle(color: subtitle2, fontSize: 16, fontWeight: FontWeight.w500),
        button1 = TextStyle(
          color: button1,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        button2 = TextStyle(
          color: button2,
          fontSize: 15,
        );

  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle heading4;
  final TextStyle body1;
  final TextStyle subtitle1;
  final TextStyle subtitle2;
  final TextStyle button1;
  final TextStyle button2;

  Map<String, TextStyle> get textStyles => {
        'Heading 1': heading1,
        'Heading 2': heading2,
        'Heading 3': heading3,
        'Heading 4': heading4,
        'Body 1': body1,
        'Subtitle 1': subtitle1,
        'Subtitle 2': subtitle2,
        'Button 1': button1,
        'Button 2': button2,
      };
}
