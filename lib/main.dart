
import 'package:Maven/feature/complete/bloc/complete_bloc/complete_bloc.dart';
import 'package:Maven/feature/setting/bloc/setting_bloc.dart';
import 'package:Maven/l10n/bloc/language_bloc/language_bloc.dart';
import 'package:Maven/tools/widget/design_tool_widget.dart';
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
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/template/bloc/template_detail/template_detail_bloc.dart';
import 'feature/workout/bloc/workout/workout_bloc.dart';
import 'generated/l10n.dart';

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
        BlocProvider(create: (context) => SettingBloc(
          settingDao: db.settingDao,
        )..add(const SettingInitialize())),
      ],
      child: const Main(),
    )
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state2) {
            return MaterialApp(
              theme: state2.theme.data,
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