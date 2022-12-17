import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';

import '../data/data.dart';
import '../model/workout.dart';
import '../widget/exercise_section.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({Key? key, required this.workout}) : super(key: key);

  final Workout workout;

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {

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
      body: SingleChildScrollView(
        child: Column(
          children: getExerciseGroupsById(widget.workout.workoutId).map((exerciseGroup) =>
              ExerciseSection(
                  exerciseGroup: exerciseGroup
              )
          ).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _navigateAndDisplaySelection(context);
        },
        backgroundColor: colors(context).backgroundLightColor,
        child: Icon(
          Icons.add,
          color: colors(context).primaryColor,
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExercisesRoute()),
    );

    setState(() {
      exercises.toList();
      exercises.add(result);
    });*/
  }
}
