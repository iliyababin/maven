import 'package:Maven/feature/profile/screen/profile_screen.dart';
import 'package:Maven/screen/home_screen.dart';
import 'package:Maven/screen/testing_screen.dart';
import 'package:Maven/screen/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'data/app_themes.dart';
import 'feature/log_workout/screen/log_workout_screen.dart';
import 'main.dart';

class Maven extends StatefulWidget {
  const Maven({super.key});

  @override
  State<Maven> createState() => _MavenState();
}

class _MavenState extends State<Maven> {
  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const WorkoutScreen(),
    const ProfileScreen(),
    const TestingScreen(),
  ];

  int selectedIndex = 0;
  int currentWorkoutId = -1;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Preference<int> currentWorkoutIdPref = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1);

    currentWorkoutIdPref.listen((value) {
      setState(() {
        currentWorkoutId = value;
      });
    });

    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      body: SafeArea(child: screens.elementAt(selectedIndex)),
      persistentFooterButtons: currentWorkoutId != -1
          ? [
              Container(
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 150),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return const LogWorkoutScreen();
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("Current Workout"),
                ),
              )
            ]
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors(context).backgroundDarkColor,
        selectedItemColor: colors(context).primaryColor,
        unselectedItemColor: colors(context).unselectedItemColor,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: "Workout"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: "Testing",
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}