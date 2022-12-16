import 'package:flutter/material.dart';

import '../data/data.dart';
import '../model/workout.dart';
import '../widgets/exercise_section.dart';

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
      appBar: AppBar(
        title: Text("Current Workout"),
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
        child: Icon(Icons.add, color: Colors.blue,),
        backgroundColor: Color(0xff3b3f52),
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
