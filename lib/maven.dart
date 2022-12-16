import 'package:flutter/material.dart';
import 'package:maven/data/app_theme.dart';
import 'package:maven/screens/home_screen.dart';
import 'package:maven/screens/profile_screen.dart';
import 'package:maven/screens/workout_screen.dart';

class Maven extends StatefulWidget {
  const Maven({super.key});

  @override
  State<Maven> createState() => _MavenState();
}

class _MavenState extends State<Maven> {

  List<Widget> screens = <Widget>[
    HomeScreen(),
    WorkoutScreen(),
    ProfileScreen(),
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
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
          child: screens.elementAt(selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: getPrimaryColor(context),
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
