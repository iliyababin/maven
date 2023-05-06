
import 'package:Maven/dev/widget/design_tool_widget.dart';
import 'package:Maven/theme/maven_theme.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'feature/workout/bloc/workout_detail/workout_detail_bloc.dart';
import 'theme/theme_options.dart';

/*Future<List<Exercise>> _loadExerciseJson() async {
  String jsonString = await rootBundle.loadString('assets/exercises.json');
  List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return jsonList.map((json) => Exercise.fromMap(json)).toList();
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final callback = Callback(
    onCreate: (database, version) { },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('maven_db_28.db')
      .addCallback(callback)
      .build();


  database.plateDao.addPlates(getDefaultPlates());
  database.barDao.addBars(getDefaultBars());
  database.exerciseDao.addExercises(getDefaultExercises());

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
          workoutDao: database.workoutDao,
          workoutExerciseGroupDao: database.workoutExerciseGroupDao,
          workoutExerciseSetDao: database.workoutExerciseSetDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )..add(WorkoutInitialize())),
        BlocProvider(create: (context) => WorkoutDetailBloc(
          workoutDao: database.workoutDao,
          workoutExerciseGroupDao: database.workoutExerciseGroupDao,
          workoutExerciseSetDao: database.workoutExerciseSetDao,
          exerciseDao: database.exerciseDao,
        )..add(const WorkoutDetailInitialize())),
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
          id: 'light_theme',
          description: 'Light Theme',
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
          ),
        ),
        MavenTheme(
          id: 'dark_theme',
          description: 'Dark Theme',
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
          ),
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) =>
            MaterialApp(
              theme: ThemeProvider.themeOf(themeContext).data,
              // TODO: Give user option to change this.
              scrollBehavior: CustomScrollBehavior(),
              title: 'Maven',
              home: Stack(children: const [
                Maven(),
                Visibility(
                  visible: kDebugMode,
                  child: DesignToolWidget(),
                ),
              ]),
            ),
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