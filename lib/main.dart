import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/database.dart';
import 'debug/screen/design_tool_widget.dart';
import 'feature/app/screen/maven.dart';
import 'feature/equipment/bloc/equipment/equipment_bloc.dart';
import 'feature/exercise/bloc/exercise_bloc.dart';
import 'feature/program/bloc/program/program_bloc.dart';
import 'feature/session/session.dart';
import 'feature/setting/bloc/setting_bloc.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/transfer/transfer.dart';
import 'feature/user/user.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'generated/l10n.dart';
import 'theme/theme.dart';

class MyErrorsHandler {
  static final MyErrorsHandler _instance = MyErrorsHandler._internal();

  factory MyErrorsHandler() {
    return _instance;
  }

  MyErrorsHandler._internal();

  void initialize() {
  }

  void onErrorDetails(FlutterErrorDetails details) {
    print('Caught error: ${details.exception}');
  }

  void onError(dynamic error, dynamic stack) {
    print('Caught error: $error');
  }

}

void main() async {
  /*final myErrorsHandler = MyErrorsHandler();
  myErrorsHandler.initialize();

  FlutterError.onError = (details) {
    myErrorsHandler.onErrorDetails(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    myErrorsHandler.onError(error, stack);
    return true;
  };*/

  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase db = await MavenDatabase.initialize();

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
                templateDataDao: db.templateDataDao,
                databaseService: databaseService,
              )..add(const TemplateInitialize())),
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
      BlocProvider(
          create: (context) => UserBloc(
            userDao: db.userDao,
          )..add(const UserInitialize())),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isLoaded) {
          return ThemeProvider(
            setting: state.setting!,
            child: Builder(
              builder: (context) {
                return MaterialApp(
                  theme: InheritedSettingWidget.of(context).setting.theme.data,
                  // TODO: Give user option to change this.
                  // scrollBehavior: CustomScrollBehavior(),
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
