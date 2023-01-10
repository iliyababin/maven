import 'package:Maven/feature/profile/screen/profile_screen.dart';
import 'package:Maven/feature/workout/bloc/active_workout/active_workout_bloc.dart';
import 'package:Maven/screen/home_screen.dart';
import 'package:Maven/screen/testing_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/template/screen/template_screen.dart';
import 'feature/workout/screen/active_workout_screen.dart';

class Maven extends StatefulWidget {
  const Maven({super.key});

  @override
  State<Maven> createState() => _MavenState();
}

class _MavenState extends State<Maven> {

  int _selectedIndex = 0;

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const TemplateScreen(),
    const ProfileScreen(),
    const TestingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mt(context).backgroundColor,
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      persistentFooterButtons: [
        persistentFooterButtons()
      ],
      bottomNavigationBar: bottomNavigationBar()
    );
  }

  ///
  /// Functions
  ///

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///
  /// Widgets
  ///

  BlocBuilder persistentFooterButtons() {
     return BlocBuilder<ActiveWorkoutBloc, ActiveWorkoutState>(
       builder: (context, state) {
         if(state.status == ActiveWorkoutStatus.active) {
           return ElevatedButton(
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => ActiveWorkoutScreen(
                     activeWorkout: state.activeWorkout!
                   )
                 )
               );
             },
             child: Text('Active Workout')
           );
         } else {
           return Container();
         }
       },
     );
    /*return [
      Container(
          child: PreferenceBuilder(
            preference: ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -2),
            builder: (context, currentWorkoutId) {
              return ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActiveWorkoutScreen()
                        )
                    );
                  },
                  child: Text(
                      "$currentWorkoutId"
                  )
              );
            },
          )
      ),
      ElevatedButton(
          onPressed: (){
            deleteCurrentWorkout(context);
          },
          child: Text(S.of(context).discard)
      ),
      ElevatedButton(
          onPressed: () async{
            *//*List<WorkoutFolder> workoutFolders = await DatabaseHelper.instance.getWorkoutFolders();
              for(var workoutFolder in workoutFolders) {
                print("id: ${workoutFolder.workoutFolderId}");
              }*//*

            List<Workout> workouts = await DBHelper.instance.getWorkouts();
            for(var workout in workouts) {
              print("name bruh: ${workout.name}");
            }

            List activeWorkouts = await DBHelper.instance.getActiveWorkouts();
            List activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroups();
            List<ActiveExerciseSet> activeExerciseSets = await DBHelper.instance.getActiveExerciseSets();
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
    ];*/
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: mt(context).bottomNavigationBar.backgroundColor,
      selectedItemColor: mt(context).bottomNavigationBar.selectedItemColor,
      unselectedItemColor: mt(context).bottomNavigationBar.unselectedItemColor,
      type: BottomNavigationBarType.fixed,
      // TODO: here unselectedIconTheme: const IconThemeData(),
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dangerous),
          label: 'Testing',
        ),
      ],
      onTap: _onItemTapped,
    );
  }


}
