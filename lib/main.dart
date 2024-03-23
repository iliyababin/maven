import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/database.dart';
import 'debug/screen/design_tool_widget.dart';
import 'feature/app/screen/app_screen.dart';
import 'feature/equipment/equipment.dart';
import 'feature/exercise/exercise.dart';
import 'feature/program/program.dart';
import 'feature/routine/service/service.dart';
import 'feature/session/session.dart';
import 'feature/settings/settings.dart';
import 'feature/template/template.dart';
import 'feature/theme/theme.dart';
import 'feature/transfer/transfer.dart';
import 'feature/user/user.dart';
import 'feature/workout/workout.dart';
import 'generated/l10n.dart';

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
      settingDao: db.settingsDao,
      exerciseGroupDao: db.baseExerciseGroupDao,
      exerciseSetDao: db.exerciseSetDao,
      exerciseSetDataDao: db.exerciseSetDataDao,
      noteDao: db.noteDao,
    );

    ExerciseService exerciseService = ExerciseService(
      exerciseDao: db.exerciseDao,
      exerciseFieldDao: db.exerciseFieldDao,
    );
    TransferService strongService = TransferService(
      exercises: getDefaultExercises(),
      importDao: db.importDao,
      exportDao: db.exportDao,
    );
    EquipmentService equipmentService = EquipmentService(
      plateDao: db.plateDao,
      barDao: db.barDao,
    );
    SettingsService settingsService = SettingsService(
      settingsDao: db.settingsDao,
      themeDao: db.themeDao,
      themeColorDao: db.themeColorDao,
    );
    RoutineService routineService = RoutineService(
      routineDao: db.routineDao,
      exerciseGroupDao: db.baseExerciseGroupDao,
      noteDao: db.noteDao,
      exerciseSetDao: db.exerciseSetDao,
      exerciseSetDataDao: db.exerciseSetDataDao,
      workoutDataDao: db.workoutDataDao,
      exerciseDao: db.exerciseDao,
      templateDataDao: db.templateDataDao,
      sessionDataDao: db.sessionDataDao,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ExerciseBloc(
                  exerciseService: exerciseService,
                )..add(const ExerciseInitialize())),
        BlocProvider(
            create: (context) => TemplateBloc(
              databaseService: databaseService,
                  routineService: routineService,
                )..add(const TemplateInitialize())),
        BlocProvider(
            create: (context) => ThemeBloc(
              themeDao: db.themeDao,
                  themeColorDao: db.themeColorDao,
                  settingDao: db.settingsDao,
                )..add(const ThemeInitialize())),
        BlocProvider(
            create: (context) => WorkoutBloc(
              databaseService: databaseService,
                  routineService: routineService,
                )..add(const WorkoutInitialize())),
        BlocProvider(
            create: (context) => EquipmentBloc(
              equipmentService: equipmentService,
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
                  routineService: routineService,
                )..add(const SessionInitialize())),
        BlocProvider(
            create: (context) => SettingsBloc(
                  settingsService: settingsService,
                )..add(const SettingsInitialize())),
        BlocProvider(
            create: (context) => UserBloc(
                  userDao: db.userDao,
                )..add(const UserInitialize())),
        BlocProvider(
            create: (context) => TransferBloc(
                  transferService: strongService,
                  routineService: routineService,
                )..add(const TransferInitialize())),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            return SettingsProvider(
              settings: state.settings!,
              child: ThemeProvider(
                useSystemTheme: state.settings!.useSystemDefaultTheme,
                child: Builder(
                  builder: (context) {
                    return DynamicColorBuilder(
                      builder: (lightDynamic, darkDynamic) {
                        return MaterialApp(
                          theme: InheritedThemeWidget.of(context).theme.data,
                          title: 'Maven',
                          localizationsDelegates: const [
                            S.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          locale: state.settings!.locale,
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
