import 'package:flutter/material.dart';
import 'package:maven/feature/create_workout/screen/create_workout_screen.dart';
import 'package:maven/feature/view_workout/screen/view_workout_screen.dart';
import 'package:maven/main.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<WorkoutProvider>(
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
                                    workoutId: workout.workoutId!)));
                      },
                      title: Text(workout.name),
                    ),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateWorkoutScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
