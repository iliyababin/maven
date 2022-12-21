import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/maven.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences ssp = await StreamingSharedPreferences.instance;
  Preference<int> test = ssp.getInt("currentWorkoutId", defaultValue: 999);
  if(test.getValue() == 999){
    ssp.setInt("currentWorkoutId", -1);
  }

  runApp(
    ISharedPrefs(
      streamingSharedPreferences: ssp,
      child: const Main()
    )
  );
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

class ISharedPrefs extends InheritedWidget {
  const ISharedPrefs({
    super.key,
    required this.streamingSharedPreferences,
    required super.child,
  });

  final StreamingSharedPreferences streamingSharedPreferences;

  static ISharedPrefs? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ISharedPrefs>();
  }

  static ISharedPrefs of(BuildContext context) {
    final ISharedPrefs? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(ISharedPrefs oldWidget) => streamingSharedPreferences != oldWidget.streamingSharedPreferences;

}