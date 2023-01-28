import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/workout/repository/active_exercise_group_repository_impl.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'feature/app/screen/maven.dart';
import 'feature/workout/template/bloc/template/template_bloc.dart';
import 'feature/workout/template/repository/exercise_group_repository_impl.dart';
import 'feature/workout/template/repository/exercise_set_repository_impl.dart';
import 'feature/workout/template/repository/template_folder_repository_impl.dart';
import 'feature/workout/template/repository/template_repository_impl.dart';
import 'feature/workout/workout/bloc/active_workout/workout_bloc.dart';
import 'feature/workout/workout/repository/active_exercise_set_repository_impl.dart';
import 'feature/workout/workout/repository/workout_repository_impl.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TemplateRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => TemplateFolderRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ExerciseGroupRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ExerciseSetRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => WorkoutRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ActiveExerciseGroupRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ActiveExerciseSetRepositoryImpl(DBHelper.instance)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TemplateBloc(
            templateRepository: context.read<TemplateRepositoryImpl>(),
            exerciseGroupRepository: context.read<ExerciseGroupRepositoryImpl>(),
            exerciseSetRepository: context.read<ExerciseSetRepositoryImpl>(),
            templateFolderRepository: context.read<TemplateFolderRepositoryImpl>(),
          )..add(TemplateInitialize())),
          BlocProvider(create: (context) => WorkoutBloc(
            workoutRepository: context.read<WorkoutRepositoryImpl>(),
            templateRepository: context.read<TemplateRepositoryImpl>(),
            activeExerciseGroupRepository: context.read<ActiveExerciseGroupRepositoryImpl>(),
            activeExerciseSetRepository: context.read<ActiveExerciseSetRepositoryImpl>(),
          )..add(WorkoutInitialize())),
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

