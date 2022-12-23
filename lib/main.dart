import 'package:Maven/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import 'data/app_themes.dart';
import 'maven.dart';
import 'model/workout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences ssp = await StreamingSharedPreferences.instance;
  Preference<int> test = ssp.getInt("currentWorkoutId", defaultValue: 999);
  if (test.getValue() == 999) {
    ssp.setInt("currentWorkoutId", -1);
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WorkoutProvider()),
    ],
    child: ISharedPrefs(streamingSharedPreferences: ssp, child: const Main()),
  ));
}

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  WorkoutProvider() {
    init();
  }

  void init() async {
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
  }

  Future<Workout?> getWorkout(int workoutId) async {
    return await DatabaseHelper.instance.getWorkout(workoutId);
  }

  Future<int> addWorkout(Workout workout) async {
    int j = await DatabaseHelper.instance.addWorkout(workout);
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED");
    return j;
  }

  void deleteWorkout(int workoutId) async {
    DatabaseHelper.instance.deleteWorkout(workoutId);
    DatabaseHelper.instance.deleteExerciseGroupsByWorkoutId(workoutId);
    DatabaseHelper.instance.deleteExerciseSetsByWorkoutId(workoutId);
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
    print("NOTIFIED 2");
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: getThemes(),
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Material App',
            home: const Maven(),
          ),
        ),
      ),
    );
  }
}

class ISharedPrefs extends InheritedWidget {
  const ISharedPrefs({
    super.key,
    required this.streamingSharedPreferences,
    required super.child,
  });

  final StreamingSharedPreferences streamingSharedPreferences;

  static ISharedPrefs? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ISharedPrefs>();
  }

  static ISharedPrefs of(BuildContext context) {
    final ISharedPrefs? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(ISharedPrefs oldWidget) => streamingSharedPreferences != oldWidget.streamingSharedPreferences;

}