import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/common/model/exercise.dart';
import 'package:maven/model/exercise_group.dart';
import 'package:maven/screen/add_exercise_screen.dart';
import 'package:maven/util/exercise_bloc.dart';
import 'package:maven/util/exercise_group_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model/workout.dart';

class LogWorkoutScreen extends StatefulWidget {
  const LogWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  final Workout workout;

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}


class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final exerciseGroupBloc = ExerciseGroupBloc();
  final exerciseBloc = ExerciseBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Current Workout"),
        titleTextStyle: TextStyle(
          color: colors(context).primaryTextColor
        ),
        backgroundColor: colors(context).backgroundLightColor,
        iconTheme: IconThemeData(
          color: colors(context).primaryTextColor
        ),
      ),
      body: StreamBuilder<List<ExerciseGroup>>(
        stream: exerciseGroupBloc.exerciseGroups,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }
          return FutureBuilder(
            future: getCurrentWorkoutsExerciseGroups(snapshot.data!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...asd'));
              }
              return ListView(
                children: snapshot.data!.map((exerciseGroup) {
                  return ListTile(
                    onTap: () async {
                    },
                    title: Text(exerciseGroup.exerciseId.toString()),
                  );
                }).toList(),
              );
            },
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
          ).then((exercise) async {
            Exercise exercise2 = exercise;
            int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
            exerciseGroupBloc.addExerciseGroup(ExerciseGroup(exerciseId: exercise2.exerciseId, workoutId: currentWorkoutId));
          });
        },
        backgroundColor: colors(context).backgroundLightColor,
        child: Icon(
          Icons.add,
          color: colors(context).primaryColor,
        ),
      ),
    );
  }

  Future<Iterable<ExerciseGroup>> getCurrentWorkoutsExerciseGroups(List<ExerciseGroup> data) async{
    int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
    return data.where((exerciseGroup) => exerciseGroup.workoutId == currentWorkoutId);
  }
}
