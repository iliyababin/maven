import 'package:Maven/feature/home/screen/home_screen.dart';
import 'package:Maven/feature/profile/screen/profile_screen.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
import 'package:Maven/screen/testing_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../common/util/general_utils.dart';
import '../../nutrition/screen/nutrition_screen.dart';
import '../../template/screen/template_screen.dart';
import '../../workout/screen/active_workout_screen.dart';

class Maven extends StatefulWidget {
  const Maven({super.key});

  @override
  State<Maven> createState() => _MavenState();
}

class _MavenState extends State<Maven> {

  int _selectedIndex = 0;

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const NutritionScreen(),
    const TemplateScreen(),
    const TestingScreen(),
    const ProfileScreen(),
  ];

  final PanelController panelController = PanelController();
  double panelPosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mt(context).backgroundColor,
      body: SafeArea(
        child: BlocBuilder<WorkoutBloc, WorkoutState>(
          builder: (context, state) {
            if(state.status == WorkoutStatus.active) {
              return SlidingUpPanel(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                minHeight: 85,
                maxHeight: MediaQuery.of(context).size.height - 50,
                backdropEnabled: true,
                controller: panelController,

                onPanelSlide: (position) {
                  setState(() {
                    panelPosition = position;
                  });
                },

                body: screens[_selectedIndex],

                collapsed: slidingPanelBackground(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        state.workout?.name ?? 'null',
                        style: TextStyle(
                          color: mt(context).text.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1)),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            workoutDuration(state.workout?.datetime ?? DateTime.now()),
                            style: TextStyle(
                              color: mt(context).text.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          );
                        },
                      )
                    ],
                  )
                ),

                panel: slidingPanelBackground(
                  const WorkoutScreen()
                )

              );
            } else {
              return screens[_selectedIndex];
            }
          },
        )
      ),
      /*persistentFooterButtons: [
        persistentFooterButtons()
      ],*/
      bottomNavigationBar: bottomNavigationBar()
    );
  }

  /*Column(
  children: [
  Expanded(child: screens[_selectedIndex]),
  workout(),
  ],
  )*/

  ///
  /// Functions
  ///

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  ///
  /// Widgets
  ///

  Container slidingPanelBackground(Widget widget) {
    return Container(
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 6,
            width: 48,
            decoration: BoxDecoration(
              color: mt(context).foregroundColor,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
          widget
        ],
      ),
    );
  }
  
  SizedBox bottomNavigationBar() {
    return SizedBox(
      height: 56 - 56 * panelPosition,
      child: BottomNavigationBar(
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
            icon: Icon(Icons.dining),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }


}
