import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/common/util/i_shared_preferences.dart';
import 'package:Maven/common/util/workout_manager.dart';
import 'package:Maven/feature/profile/screen/profile_screen.dart';
import 'package:Maven/screen/home_screen.dart';
import 'package:Maven/screen/testing_screen.dart';
import 'package:Maven/screen/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'common/theme/app_themes.dart';
import 'feature/workout/screen/log_workout_screen.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
//56 - 56 * panelController.panelPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      body: SafeArea(
        child: screens[selectedIndex],
      ),
      persistentFooterButtons: [
        PreferenceBuilder(
          preference: ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -2),
          builder: (context, currentWorkoutId) {
            return ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogWorkoutScreen()
                    )
                );
              },
              child: Text(
                "$currentWorkoutId"
              )
            );
          },
        ),
        ElevatedButton(
          onPressed: (){
           deleteCurrentWorkout(context);
          },
          child: Text("discard workout")
        ),
        ElevatedButton(
            onPressed: () async{
              List activeWorkouts = await DatabaseHelper.instance.getActiveWorkouts();
              List activeExerciseGroups = await DatabaseHelper.instance.getActiveExerciseGroups();
              List<ActiveExerciseSet> activeExerciseSets = await DatabaseHelper.instance.getActiveExerciseSets();
              print("activeWorkouts: ${activeWorkouts.length}");
              print("activeExerciseGroups: ${activeExerciseGroups.length}");
              print("activeExerciseSets: ${activeExerciseSets.length}");
            },
            child: Text("getAll")
        ),
        ElevatedButton(
            onPressed: () async{
              pauseCurrentWorkout(context);
            },
            child: Text("pause")
        ),
      ],
      bottomNavigationBar: bottomNavigationBar()
    );
  }

  PreferenceBuilder<int> collapsedContainer() {
     return PreferenceBuilder<int>(
       preference: ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1),
       builder: (context, currentWorkoutId) {
         print(currentWorkoutId);
         return Container(
           decoration: BoxDecoration(
               color: colors(context).backgroundColor,
               borderRadius: const BorderRadius.vertical(top: Radius.circular(15))
           ),
           child: Column(
             children: [
               const SizedBox(height: 14,),
               Container(
                 height: 6,
                 width: 40,
                 decoration: BoxDecoration(
                     color: colors(context).dragBarColor,
                     borderRadius: const BorderRadius.all(Radius.circular(15))
                 ),
               ),
               const SizedBox(height: 6,),
               Text(
                 "Afternoon workout",
                 style: TextStyle(
                     color: colors(context).primaryTextColor,
                     fontWeight: FontWeight.w600,
                     fontSize: 16
                 ),
               ),
               Text(
                 "id is $currentWorkoutId",
                 style: TextStyle(
                     color: colors(context).primaryTextColor,
                     fontWeight: FontWeight.w500,
                     fontSize: 13)
                 ,
               ),
             ],
           ),
         );
       },
     );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: colors(context).backgroundColor,
      selectedItemColor: colors(context).primaryColor,
      unselectedItemColor: colors(context).unselectedItemColor,
      type: BottomNavigationBarType.fixed,
      unselectedIconTheme: const IconThemeData(),
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
    );
  }
}
