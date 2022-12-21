import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/main.dart';
import 'package:maven/screen/home_screen.dart';
import 'package:maven/screen/profile_screen.dart';
import 'package:maven/screen/workout_screen.dart';
import 'package:maven/util/database_helper.dart';
import 'package:maven/util/workout_bloc.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

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

    WorkoutBloc workoutBloc = WorkoutBloc();
    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      body: SafeArea(
          child: screens.elementAt(selectedIndex)
      ),
      persistentFooterButtons: currentWorkoutId != -1 ?[
        Container(
          height: 50,
          child: Text("hey"),
        )
      ] : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors(context).backgroundColor,
        selectedItemColor: colors(context).primaryColor,
        selectedLabelStyle:  TextStyle(
          fontSize: 12,
        ),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: "Workout"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}