import 'package:flutter/material.dart';

List<ThemeData> getThemes(){
  return [
    ThemeData(
      backgroundColor: const Color(0xffffffff),
      primaryColor: const Color(0xffffffff),
      color
    ),
    ThemeData(
      backgroundColor: const Color(0xff121212),
      primaryColor: const Color(0xff282828),
    ),
  ];
}

Color getBackgroundColor(BuildContext context){
  return Theme.of(context).backgroundColor;
}

Color getPrimaryColor(BuildContext context){
  return Theme.of(context).primaryColor;
}


MaterialStateProperty<Color> getErrorColor(BuildContext context){
  return MaterialStateProperty.all<Color>(Theme.of(context).errorColor);
}