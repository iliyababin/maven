import 'package:Maven/common/util/i_shared_preferences.dart';
import 'package:Maven/common/util/provider/active_workout_provider.dart';
import 'package:Maven/common/util/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import 'common/theme/app_themes.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'maven.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences ssp = await StreamingSharedPreferences.instance;
  Preference<int> test = ssp.getInt("currentWorkoutId", defaultValue: 999);
  if (test.getValue() == 999) {
    ssp.setInt("currentWorkoutId", -1);
  }

  runApp(BlocProvider(
    create: (context) => WorkoutBloc()..add(LoadWorkoutList()),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => ActiveWorkoutProvider()),
      ],
      child: ISharedPrefs(streamingSharedPreferences: ssp, child: const Main()),
    ),
  ));
}


class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: getThemes(context),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) =>
              MaterialApp(
                theme: ThemeProvider
                    .themeOf(themeContext)
                    .data,
                title: 'Material App',
                home: const Maven(),
              ),
        ),
      ),
    );
  }
}

