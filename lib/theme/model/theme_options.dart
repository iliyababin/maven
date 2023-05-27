

import 'color_options.dart';
import 'padding_options.dart';
import 'text_style_options.dart';

abstract class ThemeOptions {
  ColorOptions get color;
  TextStyleOptions get textStyle;
  PaddingOptions get padding;
}