import 'dart:convert';

import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme_provider/theme_provider.dart';

import 'database/database.dart';
import 'feature/app/screen/maven.dart';
import 'feature/common/model/exercise.dart';
import 'feature/equipment/model/plate.dart';
import 'feature/equipment/service/equipment_service.dart';
import 'feature/template/bloc/template/template_bloc.dart';
import 'feature/template/service/template_service.dart';
import 'feature/workout/bloc/active_workout/workout_bloc.dart';

/**
 * Entry point for project, refer to documentation for further details.
 */
Future<List<Exercise>> _loadExerciseJson() async {
  String jsonString = await rootBundle.loadString('assets/exercises.json');
  List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return jsonList.map((json) => Exercise.fromMap(json)).toList();
}

GetIt services = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MavenDatabase database = await $FloorMavenDatabase
      .databaseBuilder('db040.db')
      .build();

  database.plateDao.addPlates(getDefaultPlates());
  database.exerciseDao.addExercises(await _loadExerciseJson());

  services.registerLazySingleton<EquipmentService>(() => EquipmentService(
    plateDao: database.plateDao,
  ));
  services.registerLazySingleton<TemplateService>(() => TemplateService(
    templateDao: database.templateDao,
  ));


  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => database.exerciseDao),
        RepositoryProvider(create: (context) => database.templateExerciseGroupDao),
        RepositoryProvider(create: (context) => database.templateExerciseSetDao),
        RepositoryProvider(create: (context) => database.workoutDao),
        RepositoryProvider(create: (context) => database.workoutExerciseGroupDao),
        RepositoryProvider(create: (context) => database.workoutExerciseSetDao),
        RepositoryProvider(create: (context) => database.plateDao),
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