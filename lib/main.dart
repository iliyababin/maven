
import 'dart:convert';

import 'package:Maven/theme/m_themes.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import 'database/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/equipment/bloc/equipment/equipment_bloc.dart';
import 'feature/equipment/model/bar.dart';
import 'feature/equipment/model/plate.dart';
import 'feature/exercise/bloc/exercise_bloc.dart';
import 'feature/exercise/model/exercise.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/template/bloc/template_detail/template_detail_bloc.dart';
import 'feature/workout/bloc/active_workout/workout_bloc.dart';

Future<List<Exercise>> _loadExerciseJson() async {
  String jsonString = await rootBundle.loadString('assets/exercises.json');
  List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return jsonList.map((json) => Exercise.fromMap(json)).toList();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final callback = Callback(
    onCreate: (database, version) { },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('db2.db')
      .addCallback(callback)
      .build();

  database.plateDao.addPlates(getDefaultPlates());
  database.barDao.addBars(getDefaultBars());
  database.exerciseDao.addExercises(await _loadExerciseJson());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExerciseBloc(
          exerciseDao: database.exerciseDao,
        )..add(ExerciseInitialize())),
        BlocProvider(create: (context) => TemplateBloc(
          templateDao: database.templateDao,
          templateFolderDao: database.templateFolderDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )..add(TemplateInitialize())),
        BlocProvider(create: (context) => TemplateDetailBloc(
          exerciseDao: database.exerciseDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
        )),
        BlocProvider(create: (context) => WorkoutBloc(
          exerciseDao: database.exerciseDao,
          templateDao: database.templateDao,
          templateExerciseGroupDao: database.templateExerciseGroupDao,
          templateExerciseSetDao: database.templateExerciseSetDao,
          workoutDao: database.workoutDao,
          workoutExerciseGroupDao: database.workoutExerciseGroupDao,
          workoutExerciseSetDao: database.workoutExerciseSetDao,
        )..add(WorkoutInitialize())),
        BlocProvider(create: (context) => EquipmentBloc(
          plateDao: database.plateDao,
          barDao: database.barDao,
        )..add(EquipmentInitialize())),
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
      themes: getThemes(context),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) =>
            MaterialApp(
              theme: ThemeProvider.themeOf(themeContext).data,
              // TODO: Give user option to change this.
              scrollBehavior: CustomScrollBehavior(),
              title: "Maven",
              home: const Maven(),
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