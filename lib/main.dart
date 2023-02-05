import 'dart:convert';

import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import 'database/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/workout/template/bloc/template/template_bloc.dart';
import 'feature/workout/template/model/exercise.dart';
import 'feature/workout/workout/bloc/active_workout/workout_bloc.dart';

Future<List<Exercise>> _loadExerciseJson() async {
  String jsonString = await rootBundle.loadString('assets/exercises.json');
  List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return jsonList.map((json) => Exercise.fromMap(json)).toList();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('db013.db')
      .build();

  database.exerciseDao.addExercises(await _loadExerciseJson());


  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => database.exerciseDao),
        RepositoryProvider(create: (context) => database.templateExerciseGroupDao),
        RepositoryProvider(create: (context) => database.templateExerciseSetDao),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TemplateBloc(
            templateDao: database.templateDao,
            templateFolderDao: database.templateFolderDao,
            templateExerciseGroupDao: database.templateExerciseGroupDao,
            templateExerciseSetDao: database.templateExerciseSetDao,
          )..add(TemplateInitialize())),
          BlocProvider(create: (context) => WorkoutBloc(
            exerciseDao: database.exerciseDao,
            templateDao: database.templateDao,
            templateExerciseGroupDao: database.templateExerciseGroupDao,
            templateExerciseSetDao: database.templateExerciseSetDao,
            workoutDao: database.workoutDao,
            workoutExerciseGroupDao: database.workoutExerciseGroupDao,
            workoutExerciseSetDao: database.workoutExerciseSetDao,
          )..add(WorkoutInitialize())),
        ],
        child:  const Main(),
      ),
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
              title: "Maven",
              home: const Maven(),
            ),
        ),
      ),
    );
  }
}

