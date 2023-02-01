import 'dart:convert';

import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/workout/repository/active_exercise_group_repository_impl.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import 'common/util/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/workout/template/bloc/template/template_bloc.dart';
import 'feature/workout/template/model/exercise.dart';
import 'feature/workout/template/repository/exercise_set_repository_impl.dart';
import 'feature/workout/workout/bloc/active_workout/workout_bloc.dart';
import 'feature/workout/workout/repository/active_exercise_set_repository_impl.dart';
import 'feature/workout/workout/repository/workout_repository_impl.dart';

Future<List<Exercise>> _loadExerciseJson() async {
  String jsonString = await rootBundle.loadString('assets/exercises.json');
  List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return jsonList.map((json) => Exercise.fromMap(json)).toList();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('db004.db')
      .build();

  database.exerciseDao.addExercises(await _loadExerciseJson());


  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => database.exerciseDao),
        RepositoryProvider(create: (context) => database.templateExerciseGroupDao),
        RepositoryProvider(create: (context) => ExerciseSetRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => WorkoutRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ActiveExerciseGroupRepositoryImpl(DBHelper.instance)),
        RepositoryProvider(create: (context) => ActiveExerciseSetRepositoryImpl(DBHelper.instance)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TemplateBloc(
            templateDao: database.templateDao,
            templateFolderDao: database.templateFolderDao,
            templateExerciseGroupDao: database.templateExerciseGroupDao,
            exerciseSetRepository: context.read<ExerciseSetRepositoryImpl>(),
          )..add(TemplateInitialize())),
          BlocProvider(create: (context) => WorkoutBloc(
            exerciseDao: database.exerciseDao,
            templateDao: database.templateDao,
            workoutRepository: context.read<WorkoutRepositoryImpl>(),
            templateExerciseGroupDao: database.templateExerciseGroupDao,
            activeExerciseGroupRepository: context.read<ActiveExerciseGroupRepositoryImpl>(),
            activeExerciseSetRepository: context.read<ActiveExerciseSetRepositoryImpl>(),
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

