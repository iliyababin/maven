import 'package:Maven/util/provider/active_workout_provider.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feature/workout/screen/create_workout_screen.dart';
import '../feature/workout/screen/view_workout_screen.dart';
import '../util/provider/workout_provider.dart';
import '../util/workout_manager.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateWorkoutScreen()
                  )
              );
            },
            child: Text("Create Workout"),
          ),
          const Text("Paused workouts:"),
          Expanded(
            child: Consumer<ActiveWorkoutProvider>(
              builder: (context, activeWorkoutProvider, child) {
                return ListView(
                  children: activeWorkoutProvider.pausedActiveWorkouts.map((activeWorkout) {
                    return ListTile(
                      onTap: () {
                        unpauseWorkout(context, activeWorkout.activeWorkoutId!);
                      },
                      title: Text(activeWorkout.name),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Text("Workout templates:"),
          Expanded(
            child: Consumer<WorkoutProvider>(
              builder: (context, workoutProvider, child) {
                return ListView(
                  children: workoutProvider.workouts.map((workout) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        Provider.of<WorkoutProvider>(context, listen: false)
                            .deleteWorkout(workout.workoutId!);
                      },
                      child: ListTile(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewWorkoutScreen(
                                workoutId: workout.workoutId!
                              )
                            )
                          );
                        },
                        title: Text(workout.name),
                        subtitle: Text(workout.workoutId.toString()),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
      context: context,
    );
  }
}