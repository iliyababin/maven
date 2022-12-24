import 'package:flutter/material.dart';

import '../../../common/model/exercise_group.dart';
import '../../../main.dart';
import '../../../util/database_helper.dart';

class LogWorkoutScreen extends StatefulWidget {
  const LogWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    int currentWorkoutId = ISharedPrefs.of(context)
        .streamingSharedPreferences
        .getInt("currentWorkoutId", defaultValue: -1)
        .getValue();

    return Scaffold(
      appBar: AppBar(
        title: Text("This is a workout!"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.expand_more),
        ),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance
            .getExerciseGroupsByWorkoutId(currentWorkoutId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          List<ExerciseGroup> exerciseGroups = snapshot.data ?? [];
          return ListView.builder(
            itemCount: exerciseGroups.length,
            itemBuilder: (context, index) {
              ExerciseGroup exerciseGroup = exerciseGroups[index];
              return Text(exerciseGroup.exerciseId.toString());
            },
          );
        },
      ),
    );
  }
}
