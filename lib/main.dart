
import 'package:Maven/feature/complete/bloc/complete_bloc/complete_bloc.dart';
import 'package:Maven/l10n/bloc/language_bloc/language_bloc.dart';
import 'package:Maven/theme/maven_theme.dart';
import 'package:Maven/tools/widget/design_tool_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'database/database.dart';
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

  final MavenDatabase db = await MavenDatabase.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExerciseBloc(
          exerciseDao: db.exerciseDao,
        )..add(const ExerciseInitialize())),
        BlocProvider(create: (context) => TemplateBloc(
          templateDao: db.templateDao,
          templateTrackerDao: db.templateTrackerDao,
          templateExerciseGroupDao: db.templateExerciseGroupDao,
          templateExerciseSetDao: db.templateExerciseSetDao,
        )..add(const TemplateInitialize())),
        BlocProvider(create: (context) => TemplateDetailBloc(
          templateDao: db.templateDao,
          exerciseDao: db.exerciseDao,
          templateExerciseGroupDao: db.templateExerciseGroupDao,
          templateExerciseSetDao: db.templateExerciseSetDao,
        )),
        BlocProvider(create: (context) => WorkoutBloc(
          exerciseDao: db.exerciseDao,
          workoutDao: db.workoutDao,
          workoutExerciseGroupDao: db.workoutExerciseGroupDao,
          workoutExerciseSetDao: db.workoutExerciseSetDao,
          templateExerciseGroupDao: db.templateExerciseGroupDao,
          templateExerciseSetDao: db.templateExerciseSetDao,
          completeDao: db.completeDao,
          completeExerciseGroupDao: db.completeExerciseGroupDao,
          completeExerciseSetDao: db.completeExerciseSetDao,
        )..add(const WorkoutInitialize())),
        BlocProvider(create: (context) => EquipmentBloc(
          plateDao: db.plateDao,
          barDao: db.barDao,
        )..add(const EquipmentInitialize())),
        BlocProvider(create: (context) => ProgramBloc(
          programDao: db.programDao,
          folderDao: db.folderDao,
          templateDao: db.templateDao,
          templateTrackerDao: db.templateTrackerDao,
          templateExerciseGroupDao: db.templateExerciseGroupDao,
          templateExerciseSetDao: db.templateExerciseSetDao,
        )..add(const ProgramInitialize())),
        BlocProvider(create: (context) => ProgramDetailBloc(
          programDao: db.programDao,
          folderDao: db.folderDao,
          templateDao: db.templateDao,
          templateTrackerDao: db.templateTrackerDao,
        )..add(ProgramDetailInitialize())),
        BlocProvider(create: (context) => LanguageBloc(
          settingDao: db.settingDao,
        )..add(const LanguageInitialize())),
        BlocProvider(create: (context) => CompleteBloc(
          completeDao: db.completeDao,
          exerciseDao: db.exerciseDao,
          completeExerciseGroupDao: db.completeExerciseGroupDao,
          completeExerciseSetDao: db.completeExerciseSetDao,
          workoutDao: db.workoutDao,
        )..add(const CompleteInitialize())),
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
          id: 'assets/image/light.jpg',
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
          id: 'assets/image/dark.jpg',
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
          id: 'assets/image/solar_flare.jpg',
          description: 'Solar flare',
          options: ThemeOptions(
            primary: const Color(0xFFFFAE00),
            secondary: const Color(0xFF333333),
            background: const Color(0xff232323),
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
        MavenTheme(
          id: 'assets/image/nature.jpg',
          description: 'Nature',
          options: ThemeOptions(
            primary: const Color(0xFF4CAF50),
            secondary: const Color(0xFF8BC34A),
            background: const Color(0xFFE8F5E9),
            text: const Color(0xFF212121),
            subtext: const Color(0xFF757575),
            neutral: const Color(0xFFFFFFFF),
            success: const Color(0xFF4CAF50),
            error: const Color(0xFFDD614A),
            shadow: const Color(0xFFBDBDBD),
            warmup: const Color(0xFFFFAE00),
            drop: const Color(0xFFBD4ADD),
            cooldown: const Color(0xFF21F3F3),
          ),
        ),
        MavenTheme(
          id: 'assets/image/rose_gold.jpg',
          description: 'Rose Gold',
          options: ThemeOptions(
            primary: const Color(0xFFE91E63),
            secondary: const Color(0xFFFFDF9F),
            background: const Color(0xFFFAF0E6),
            text: const Color(0xFF212121),
            subtext: const Color(0xFF757575),
            neutral: const Color(0xFFFFFFFF),
            success: const Color(0xFFAF4C4C),
            error: const Color(0xFFDD614A),
            shadow: const Color(0xFFBDBDBD),
            warmup: const Color(0xFFFFAE00),
            drop: const Color(0xFFBD4ADD),
            cooldown: const Color(0xFF21F3F3),
          ),
        ),
        MavenTheme(
          id: 'assets/image/custom.jpg',
          description: 'Custom',
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