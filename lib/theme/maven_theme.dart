import 'package:Maven/theme/theme_options.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MavenTheme extends AppTheme {
  MavenTheme({
    required final String id,
    required final String description,
    required final ThemeOptions options,
  }) : super(
    id: id,
    data: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1,
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
      iconTheme: IconThemeData(
        color: options.color.primary,
      ),
      scaffoldBackgroundColor: options.color.background,
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.only(left: 20)
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.selected)) {
            return options.color.primary;
          } else {
            return options.color.secondary;
          }
        }),
        checkColor: MaterialStateProperty.all(options.color.background),
      )
    ),
    description: description,
    options: options
  );
}

