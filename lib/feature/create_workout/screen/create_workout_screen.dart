
import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/screen/add_exercise_screen.dart';
import 'package:maven/widget/exercise_section.dart';

import '../../../common/model/exercise.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {

  List<Exercise> exercises = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colors(context).primaryTextColor
        ),
        title: Text(
          'Create workout',
          style: TextStyle(
            color: colors(context).primaryTextColor
          ),
        ),
        backgroundColor: colors(context).backgroundColor,
        actions: [
          TextButton(
            onPressed: (){
              exercises.first.
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: colors(context).accentTextColor
              ),
            )
          )
        ],
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
                hintText: 'Workout title'
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (BuildContext context, int index) {
                Exercise exercise = exercises[index];
                return ExerciseSection(exercise: exercise, active: false,);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExerciseScreen())
          ).then((exercise) => {
            setState(() {
              exercises.add(exercise);
            })
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
