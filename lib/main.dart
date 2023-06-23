import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/equipment/bloc/equipment/equipment_bloc.dart';
import 'feature/exercise/bloc/exercise_bloc.dart';
import 'feature/program/bloc/program/program_bloc.dart';
import 'feature/program/bloc/program_detail/program_detail_bloc.dart';
import 'feature/session/bloc/session_bloc/session_bloc.dart';
import 'feature/session/bloc/session_exercise/complete_exercise_bloc.dart';
import 'feature/setting/bloc/setting_bloc.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/template/bloc/template_detail/template_detail_bloc.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'generated/l10n.dart';
import 'theme/theme.dart';
import 'theme/widget/design_tool_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase db = await MavenDatabase.initialize();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => ExerciseBloc(
                exerciseDao: db.exerciseDao,
                exerciseFieldDao: db.exerciseFieldDao,
              )..add(const ExerciseInitialize())),
      BlocProvider(
          create: (context) => TemplateBloc(
                templateDao: db.templateDao,
                templateTrackerDao: db.templateTrackerDao,
                templateExerciseGroupDao: db.templateExerciseGroupDao,
                templateExerciseSetDao: db.templateExerciseSetDao,
                templateExerciseSetDataDao: db.templateExerciseSetDataDao,
              )..add(const TemplateInitialize())),
      BlocProvider(
          create: (context) => TemplateDetailBloc(
                templateDao: db.templateDao,
                exerciseDao: db.exerciseDao,
                templateExerciseGroupDao: db.templateExerciseGroupDao,
                templateExerciseSetDao: db.templateExerciseSetDao,
                templateExerciseSetDataDao: db.templateExerciseSetDataDao,
                exerciseFieldDao: db.exerciseFieldDao,
              )),
      BlocProvider(
          create: (context) => WorkoutBloc(
                exerciseDao: db.exerciseDao,
                exerciseFieldDao: db.exerciseFieldDao,
                workoutDao: db.workoutDao,
                workoutExerciseGroupDao: db.workoutExerciseGroupDao,
                workoutExerciseSetDao: db.workoutExerciseSetDao,
                workoutExerciseSetDataDao: db.workoutExerciseSetDataDao,
                templateExerciseGroupDao: db.templateExerciseGroupDao,
                templateExerciseSetDao: db.templateExerciseSetDao,
                completeDao: db.sessionDao,
                completeExerciseGroupDao: db.sessionExerciseGroupDao,
                completeExerciseSetDao: db.sessionExerciseSetDao,
                templateExerciseSetDataDao: db.templateExerciseSetDataDao,
              )..add(const WorkoutInitialize())),
      BlocProvider(
          create: (context) => EquipmentBloc(
                plateDao: db.plateDao,
                barDao: db.barDao,
              )..add(const EquipmentInitialize())),
      BlocProvider(
          create: (context) => ProgramBloc(
                programDao: db.programDao,
                folderDao: db.folderDao,
                templateDao: db.templateDao,
                templateTrackerDao: db.templateTrackerDao,
                templateExerciseGroupDao: db.templateExerciseGroupDao,
                templateExerciseSetDao: db.templateExerciseSetDao,
              )..add(const ProgramInitialize())),
      BlocProvider(
          create: (context) => ProgramDetailBloc(
                programDao: db.programDao,
                folderDao: db.folderDao,
                templateDao: db.templateDao,
                templateTrackerDao: db.templateTrackerDao,
              )..add(ProgramDetailInitialize())),
      BlocProvider(
          create: (context) => SessionBloc(
                sessionDao: db.sessionDao,
                exerciseDao: db.exerciseDao,
                sessionExerciseGroupDao: db.sessionExerciseGroupDao,
                sessionExerciseSetDao: db.sessionExerciseSetDao,
                sessionExerciseSetDataDao: db.sessionExerciseSetDataDao,
                workoutDao: db.workoutDao,
              )..add(const SessionInitialize())),
      BlocProvider(
          create: (context) => CompleteExerciseBloc(
                completeDao: db.sessionDao,
                completeExerciseGroupDao: db.sessionExerciseGroupDao,
                completeExerciseSetDao: db.sessionExerciseSetDao,
              )..add(const CompleteExerciseInitialize())),
      BlocProvider(
          create: (context) => SettingBloc(
                settingDao: db.settingDao,
              )..add(const SettingInitialize())),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isLoaded) {
          return ThemeProvider(
            theme: AppTheme.themes.firstWhere((element) => element.id == state.themeId),
            themes: AppTheme.themes,
            child: Builder(
              builder: (context) {
                return MaterialApp(
                  theme: InheritedThemeWidget.of(context).theme.data,
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
                  home: const Stack(children: [
                    Maven(),
                    Visibility(
                      visible: kDebugMode,
                      child: DesignToolWidget(),
                    ),
                  ]),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
