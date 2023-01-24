import 'package:Maven/common/repository/template_repository_impl.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/template/bloc/template/template_bloc.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'feature/app/screen/maven.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TemplateRepositoryImpl(DBHelper.instance)
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TemplateBloc()..add(InitializeTemplateBloc())
          ),
          BlocProvider(
            create: (context) => WorkoutBloc()..add(InitializeWorkoutBloc())
          ),
        ],
        child:  const Main(),
      ),
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
      themes: getThemes(context),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) =>
            MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeProvider.themeOf(themeContext).data,
              title: "Maven",
              home: const Maven(),
            ),
        ),
      ),
    );
  }
}

