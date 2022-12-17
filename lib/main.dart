import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/maven.dart';
import 'package:theme_provider/theme_provider.dart';

Future main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: getThemes(),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Material App',
            home: const Maven(),
          ),
        ),
      ),
    );
  }
}