import 'package:Maven/feature/profile/screen/profile_screen.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
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
        child: Column(
          children: [
            Expanded(child: screens[_selectedIndex]),
            workout(),
          ],
        ),
      ),
      /*persistentFooterButtons: [
        persistentFooterButtons()
      ],*/
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

  BlocBuilder workout() {
     return BlocBuilder<WorkoutBloc, WorkoutState>(
       builder: (context, state) {
         if(state.status == WorkoutStatus.active) {
           return Container(
             height: 75,
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
               color: mt(context).bottomNavigationBar.backgroundColor,
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.2),
                   spreadRadius: 5,
                   blurRadius: 7,
                   offset: Offset(0, 3), // changes position of shadow
                 ),
               ],
             ),
             child: Center(
               child: ElevatedButton(
                   onPressed: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => WorkoutScreen(
                                 workout: state.workout!
                             )
                         )
                     );
                   },
                   child: Text('Active Workout')
               ),
             ),
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
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout',
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
