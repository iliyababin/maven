import 'package:Maven/theme/m_theme_scheme.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MavenTheme extends AppTheme {
  MavenTheme({
    required final String id,
    required final String description,
    required final MavenThemeOptions options,
  }) : super(
    id: id,
    data: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1,
        backgroundColor: options.color.background,
        iconTheme: IconThemeData(
          color: options.color.primary,
        ),
      ),
      scaffoldBackgroundColor: options.color.background,
    ),
    description: description,
    options: options
  );
}

