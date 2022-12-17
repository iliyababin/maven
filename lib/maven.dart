import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/screen/home_screen.dart';
import 'package:maven/screen/profile_screen.dart';
import 'package:maven/screen/workout_screen.dart';

import 'package:theme_provider/theme_provider.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      body: SafeArea(
          child: screens.elementAt(selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors(context).backgroundColor,
        selectedItemColor: colors(context).primaryColor,
        selectedLabelStyle: const TextStyle(
          fontSize: 12
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
              label: "Profile"
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}