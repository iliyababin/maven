import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/feature/log_workout/screen/log_workout_screen.dart';
import 'package:maven/model/exercise_group.dart';
import 'package:maven/model/workout.dart';
import 'package:maven/util/database_helper.dart';

import '../../../common/model/exercise.dart';
import '../../../main.dart';

class ViewWorkoutScreen extends StatefulWidget {
  const ViewWorkoutScreen({Key? key, required this.workoutId})
      : super(key: key);

  final int workoutId;

  @override
  State<ViewWorkoutScreen> createState() => _ViewWorkoutScreenState();
}

class _ViewWorkoutScreenState extends State<ViewWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: DatabaseHelper.instance.getWorkout(widget.workoutId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading');
            }
            Workout workout = snapshot.data!;
            return Column(
              children: [
                Text(workout.name),
                getListOfExercises(widget.workoutId)
              ],
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                int currentWorkoutIdPref = ISharedPrefs.of(context)
                    .streamingSharedPreferences
                    .getInt("currentWorkoutId", defaultValue: -1)
                    .getValue();
                if (currentWorkoutIdPref != -1) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Workout in progress"),
                        content: const Text(
                            "You already have a workout in progress, would you like to discard it?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "Discard",
                              style:
                                  TextStyle(color: colors(context).errorColor),
                            ),
                            onPressed: () {
                              // Perform the "Yes" action
                              Navigator.of(context).pop(true);
                            },
                          ),
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ],
                      );
                    },
                  ).then((value) {
                    if (value) {
                      ISharedPrefs.of(context)
                          .streamingSharedPreferences
                          .setInt("currentWorkoutId", widget.workoutId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogWorkoutScreen()));
                    }
                  });
                }
              },
              child: const Text("START")),
        )
      ],
    );
  }

  FutureBuilder getListOfExercises(int workoutId) {
    return FutureBuilder(
      future: DatabaseHelper.instance
          .getExerciseGroupsByWorkoutId(widget.workoutId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading exercises');
        List<ExerciseGroup> exerciseGroups = snapshot.data;
        return ListView.builder(
          itemCount: exerciseGroups.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ExerciseGroup exerciseGroup = exerciseGroups[index];
            return FutureBuilder(
              future:
                  DatabaseHelper.instance.getExercise(exerciseGroup.exerciseId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading exercise');
                Exercise exercise = snapshot.data!;
                return ListTile(
                  onTap: () {},
                  leading: Container(
                    height: 50,
                    child: Image.asset(
                      'assets/squat.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(exercise.name),
                  subtitle: FutureBuilder(
                    future: DatabaseHelper.instance
                        .getExerciseSetsByExerciseGroupId(
                            exerciseGroup.exerciseGroupId!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Text('Loading exercise');
                      int? length = snapshot.data?.length;
                      return Text("$length sets x 10 reps");
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
