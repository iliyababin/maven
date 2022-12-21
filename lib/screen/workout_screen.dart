import 'package:flutter/material.dart';
import 'package:maven/main.dart';
import 'package:maven/model/workout.dart';
import 'package:maven/features/create_workout/screen/create_workout_screen.dart';
import 'package:maven/screen/log_workout_screen.dart';
import 'package:maven/util/workout_bloc.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final workoutBloc = WorkoutBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<List<Workout>>(
            stream: workoutBloc.workouts,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading..s.'));
              }
              return ListView(
                children: snapshot.data!.map((workout) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      workoutBloc.deleteWorkout(workout.workoutId!);
                    },
                    child: ListTile(
                      onTap: () async {
                        int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();

                        if(currentWorkoutId == -1){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Warning'),
                                content: Text('Do you want to start the workout?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LogWorkoutScreen(workout: workout))
                                      );
                                      ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", workout.workoutId ?? -1);
                                    },
                                    child: Text('Start'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Confirm action
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Warning'),
                                content: Text(
                                    "There's already a workout, would you like to discard it?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Confirm action
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      title: Text(workout.name),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateWorkoutScreen())
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
