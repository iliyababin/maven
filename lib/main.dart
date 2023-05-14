
import 'package:Maven/feature/complete/bloc/complete_bloc/complete_bloc.dart';
import 'package:Maven/l10n/bloc/language_bloc/language_bloc.dart';
import 'package:Maven/theme/maven_theme.dart';
import 'package:Maven/tools/widget/design_tool_widget.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'database/database.dart';
import 'database/model/model.dart';
import 'feature/app/screen/maven.dart';
import 'feature/equipment/bloc/equipment/equipment_bloc.dart';
import 'feature/exercise/bloc/exercise_bloc.dart';
import 'feature/program/bloc/program/program_bloc.dart';
import 'feature/program/bloc/program_detail/program_detail_bloc.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/template/bloc/template_detail/template_detail_bloc.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'generated/l10n.dart';
import 'theme/theme_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final callback = Callback(
    onCreate: (database, version) {
      database.rawInsert('INSERT INTO setting (id, language_code, country_code) VALUES (1, "en", "US")');
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('maven_db_40.db')
      .addCallback(callback)
      .build();

  database.plateDao.addPlates(getDefaultPlates());
  database.barDao.addBars(getDefaultBars());
  database.exerciseDao.addExercises(getDefaultExercises());

  final test = await database.workoutDao.getWorkouts();
  print(test);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExerciseBloc(
          exerciseDao: database.exerciseDao,
        )..add(ExerciseInitialize())),
        BlocProvider(create: (context) => TemplateBloc(
          templateDao: database.templateDao,
          templateTrackerDao: database.templateTrackerDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )..add(const TemplateInitialize())),
        BlocProvider(create: (context) => TemplateDetailBloc(
          exerciseDao: database.exerciseDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )),
        BlocProvider(create: (context) => WorkoutBloc(
          exerciseDao: database.exerciseDao,
          workoutDao: database.workoutDao,
          workoutExerciseGroupDao: database.workoutExerciseGroupDao,
          workoutExerciseSetDao: database.workoutExerciseSetDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
          completeDao: database.completeDao,
          completeExerciseGroupDao: database.completeExerciseGroupDao,
          completeExerciseSetDao: database.completeExerciseSetDao,
        )..add(WorkoutInitialize())),
        BlocProvider(create: (context) => EquipmentBloc(
          plateDao: database.plateDao,
          barDao: database.barDao,
        )..add(EquipmentInitialize())),
        BlocProvider(create: (context) => ProgramBloc(
          programDao: database.programDao,
          folderDao: database.folderDao,
          templateDao: database.templateDao,
          templateTrackerDao: database.templateTrackerDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )..add(ProgramInitialize())),
        BlocProvider(create: (context) => ProgramDetailBloc(
          programDao: database.programDao,
          folderDao: database.folderDao,
          templateDao: database.templateDao,
          templateTrackerDao: database.templateTrackerDao,
        )..add(ProgramDetailInitialize())),
        BlocProvider(create: (context) => LanguageBloc(
          settingDao: database.settingDao,
        )..add(const LanguageInitialize())),
        BlocProvider(create: (context) => CompleteBloc(
          completeDao: database.completeDao,
          completeExerciseGroupDao: database.completeExerciseGroupDao,
          completeExerciseSetDao: database.completeExerciseSetDao,
          workoutDao: database.workoutDao,
        )..add(CompleteInitialize())),
      ],
      child: const Main(),
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
      themes: [
        MavenTheme(
          id: 'light',
          description: 'Light',
          options: ThemeOptions(
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFFEAEAEA),
            background: const Color(0xffffffff),
            text: const Color(0xff000000),
            subtext: const Color(0xFF808080),
            neutral: const Color(0xFFFFFFFF),
            success: const Color(0xFF2DCD70),
            error: const Color(0xFFDD614A),
            shadow: const Color(0xFFC1C1C1),
            warmup: const Color(0xFFFFAE00),
            drop: const Color(0xFFBD4ADD),
            cooldown: const Color(0xFF21F3F3),
          ),
        ),
        MavenTheme(
          id: 'dark',
          description: 'Dark',
          options: ThemeOptions(
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFF333333),
            background: const Color(0xff121212),
            text: const Color(0xffffffff),
            subtext: const Color(0xFF808080),
            neutral: const Color(0xFFFFFFFF),
            success: const Color(0xFF2DCD70),
            error: const Color(0xFFDD614A),
            shadow: const Color(0xFF353535),
            warmup: const Color(0xFFFFAE00),
            drop: const Color(0xFFBD4ADD),
            cooldown: const Color(0xFF21F3F3),
          ),
        ),
        MavenTheme(
          id: 'meteorite_mauve',
          description: 'Solar flare',
          options: ThemeOptions(
            primary: const Color(0xFFFFAE00),
            secondary: const Color(0xFF333333),
            background: const Color(0xff121212),
            text: const Color(0xffffffff),
            subtext: const Color(0xFF808080),
            neutral: const Color(0xFFFFFFFF),
            success: const Color(0xFF922DCD),
            error: const Color(0xFFDD614A),
            shadow: const Color(0xFF353535),
            warmup: const Color(0xFFFFAE00),
            drop: const Color(0xFFBD4ADD),
            cooldown: const Color(0xFF21F3F3),
          ),
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return MaterialApp(
                  theme: ThemeProvider.themeOf(themeContext).data,
                  // TODO: Give user option to change this.
                  scrollBehavior: CustomScrollBehavior(),
                  title: 'Maven',
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: state.locale,
                  supportedLocales: S.delegate.supportedLocales,
                  home: Stack(children: const [
                    Maven(),
                    Visibility(
                      visible: kDebugMode,
                      child: DesignToolWidget(),
                    ),
                  ]),
                );
              },
            );
          }
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}