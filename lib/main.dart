import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maven/feature/theme/widget/inherited_theme_widget.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';
import 'debug/screen/design_tool_widget.dart';
import 'feature/app/screen/app_screen.dart';
import 'feature/equipment/equipment.dart';
import 'feature/exercise/exercise.dart';
import 'feature/program/program.dart';
import 'feature/session/session.dart';
import 'feature/settings/settings.dart';
import 'feature/template/template.dart';
import 'feature/transfer/transfer.dart';
import 'feature/user/user.dart';
import 'feature/workout/workout.dart';
import 'generated/l10n.dart';
import 'feature/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase db = await MavenDatabase.initialize();

/*int routineId = await db.routineDao.add(Routine(
    name: 'Session',
    note: '',
    timestamp: DateTime.now().subtract(const Duration(days: 7)),
    type: RoutineType.session,
  ));

  db.sessionDataDao.add(SessionData(
    timeElapsed: const Timed.zero(),
    routineId: routineId
  ));*/

  runApp(
    Main(
      db: db,
    ),
  );
}

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.db,
  });

  final MavenDatabase db;

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(
      exerciseDao: db.exerciseDao,
      settingDao: db.settingDao,
      exerciseGroupDao: db.baseExerciseGroupDao,
      exerciseSetDao: db.exerciseSetDao,
      exerciseSetDataDao: db.exerciseSetDataDao,
      noteDao: db.noteDao,
    );

    TransferService strongService = TransferService(
      exercises: getDefaultExercises(),
    );

    return MultiBlocProvider(
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
                  templateDataDao: db.templateDataDao,
                  databaseService: databaseService,
                )..add(const TemplateInitialize())),
        BlocProvider(
            create: (context) => ThemeBloc(
                  themeDao: db.themeDao,
                  themeColorDao: db.themeColorDao,
                  settingDao: db.settingDao,
                )..add(const ThemeInitialize())),
        BlocProvider(
            create: (context) => WorkoutBloc(
                  routineDao: db.routineDao,
                  exerciseGroupDao: db.baseExerciseGroupDao,
                  noteDao: db.noteDao,
                  exerciseSetDao: db.exerciseSetDao,
                  exerciseSetDataDao: db.exerciseSetDataDao,
                  workoutDataDao: db.workoutDataDao,
                  databaseService: databaseService,
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
                  databaseService: databaseService,
                  sessionDataDao: db.sessionDataDao,
                  transferService: strongService,
                  importDao: db.importDao,
                )..add(const SessionInitialize())),
        BlocProvider(
            create: (context) => SettingBloc(
                  settingDao: db.settingDao,
                  themeDao: db.themeDao,
                  themeColorDao: db.themeColorDao,
                )..add(const SettingInitialize())),
        BlocProvider(
            create: (context) => UserBloc(
                  userDao: db.userDao,
                )..add(const UserInitialize())),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          log('Entire Widget Tree');
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            return SettingProvider(
              setting: state.setting!,
              child: ThemeProvider(
                child: Builder(
                  builder: (context) {
                    return MaterialApp(
                      theme: InheritedThemeWidget.of(context).theme.data,
                      title: 'Maven',
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: state.setting!.locale,
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
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  // TODO: Give user option to change this.
  // scrollBehavior: CustomScrollBehavior(),
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
