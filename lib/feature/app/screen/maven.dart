import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../common/util/general_utils.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../home/screen/home_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../../progress/screen/progress_screen.dart';
import '../../template/screen/template_screen.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../../workout/screen/workout_screen.dart';

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
    const ProgressScreen(),
    const ProfileScreen(),
  ];

  final PanelController panelController = PanelController();
  double panelPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: T(context).color.background,
      body: SafeArea(
        child: BlocBuilder<WorkoutBloc, WorkoutState>(
          builder: (context, state) {
            if(state.status.isLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if(state.status.isNone) {
              return screens[_selectedIndex];
            } else if(state.status.isActive) {

              return SlidingUpPanel(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                minHeight: 70,
                maxHeight: MediaQuery.of(context).size.height,
                backdropEnabled: true,
                controller: panelController,
                color: T(context).color.background,
                onPanelSlide: (position) {
                  /*setState(() {
                    panelPosition = position;
                  });*/
                },
                boxShadow: [
                  BoxShadow(
                    color: T(context).color.shadow,
                    blurRadius: 3,

                  ),
                ],
                body: screens[_selectedIndex],
                collapsed: IgnorePointer(
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                      color: T(context).color.background,

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Container(
                          height: 6,
                          width: 48,
                          decoration: BoxDecoration(
                            color: T(context).color.secondary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.workout!.name,
                          style: T(context).textStyle.heading3,
                        ),
                        const SizedBox(height: 1),
                        StreamBuilder(
                          stream: Stream.periodic(Duration(seconds: 1)),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            return Text(
                              workoutDuration(state.workout?.timestamp ?? DateTime.now()),
                              style: T(context).textStyle.subtitle1,
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                panel: Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: T(context).color.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Container(
                        height: 6,
                        width: 48,
                        decoration: BoxDecoration(
                          color: T(context).color.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                       WorkoutScreen(
                         workout: state.workout!,
                         exerciseBundles: state.exerciseBundles,
                       ),
                    ],
                  ),
                ),
              );
            } else {
              return Text(
                'Naughty Error',
                style: T(context).textStyle.body1,
              );
            }
          },
        )
      ),
      bottomNavigationBar: bottomNavigationBar() /*NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )*/
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

  
  SizedBox bottomNavigationBar() {
    return SizedBox(
      height: /*56 - 56 * panelPosition*/ 60 ,
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
