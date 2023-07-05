import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/equipment/bloc/equipment/equipment_bloc.dart';
import 'feature/exercise/bloc/exercise_bloc.dart';
import 'feature/program/bloc/program/program_bloc.dart';
import 'feature/session/session.dart';
import 'feature/setting/bloc/setting_bloc.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'generated/l10n.dart';
import 'theme/theme.dart';
import 'theme/widget/design_tool_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase db = await MavenDatabase.initialize();

  ExerciseGroupService exerciseGroupService = ExerciseGroupService(
    exerciseGroupDao: db.baseExerciseGroupDao,
    exerciseSetDao: db.exerciseSetDao,
    exerciseSetDataDao: db.exerciseSetDataDao,
    noteDao: db.noteDao,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => ExerciseBloc(
                exerciseDao: db.exerciseDao,
                exerciseFieldDao: db.exerciseFieldDao,
              )..add(const ExerciseInitialize())),
      BlocProvider(
          create: (context) => TemplateBloc(
                exerciseDao: db.exerciseDao,
                exerciseGroupDao: db.baseExerciseGroupDao,
                exerciseSetDao: db.exerciseSetDao,
                exerciseSetDataDao: db.exerciseSetDataDao,
                routineDao: db.routineDao,
                noteDao: db.noteDao,
              )..add(const TemplateInitialize())),
      BlocProvider(
          create: (context) => WorkoutBloc(
                routineDao: db.routineDao,
                exerciseGroupDao: db.baseExerciseGroupDao,
                noteDao: db.noteDao,
                exerciseSetDao: db.exerciseSetDao,
                exerciseSetDataDao: db.exerciseSetDataDao,
                workoutDataDao: db.workoutDataDao,
                exerciseGroupService: exerciseGroupService,
              )..add(const WorkoutInitialize())),
      BlocProvider(
          create: (context) => EquipmentBloc(
                plateDao: db.plateDao,
                barDao: db.barDao,
              )..add(const EquipmentInitialize())),
      BlocProvider(
          create: (context) => ProgramBloc(
                exerciseDao: db.exerciseDao,
                programDao: db.programDao,
                programFolderDao: db.programFolderDao,
                programTemplateDao: db.programTemplateDao,
                programExerciseGroupDao: db.programExerciseGroupDao,
              )..add(const ProgramInitialize())),
      BlocProvider(
          create: (context) => SessionBloc(
                routineDao: db.routineDao,
                exerciseGroupDao: db.baseExerciseGroupDao,
                noteDao: db.noteDao,
                exerciseSetDao: db.exerciseSetDao,
                exerciseSetDataDao: db.exerciseSetDataDao,
                exerciseGroupService: exerciseGroupService,
                sessionDataDao: db.sessionDataDao,
              )..add(const SessionInitialize())),
      /*BlocProvider(
          create: (context) => SessionExerciseBloc(
                completeDao: db.sessionDao,
                completeExerciseGroupDao: db.sessionExerciseGroupDao,
                completeExerciseSetDao: db.sessionExerciseSetDao,
              )..add(const SessionExerciseInitialize())),*/
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
                  // scrollBehavior: CustomScrollBehavior(),
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
