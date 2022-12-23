import 'package:flutter/material.dart';
import 'package:maven/common/model/exercise_set.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/feature/create_workout/model/exercise_block.dart';
import 'package:maven/feature/create_workout/widget/exercise_block_widget.dart';
import 'package:maven/model/exercise_group.dart';
import 'package:maven/model/workout.dart';
import 'package:maven/screen/add_exercise_screen.dart';
import 'package:maven/util/database_helper.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  List<ExerciseBlockData> exerciseBlocks = List.empty(growable: true);
  final workoutTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors(context).primaryTextColor),
        title: Text(
          'Create workout',
          style: TextStyle(
            color: colors(context).primaryTextColor
          ),
        ),
        backgroundColor: colors(context).backgroundColor,
        actions: [
          TextButton(
              onPressed: () async {
                if (workoutTitleController.text.isEmpty) {
                  const snackBar = SnackBar(
                    content: Text('Enter a workout title'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                int test =
                    await Provider.of<WorkoutProvider>(context, listen: false)
                        .addWorkout(Workout(name: workoutTitleController.text));
                print(test);
                for (var exerciseBlock in exerciseBlocks) {
                  int exerciseGroupId = await DatabaseHelper.instance
                      .addExerciseGroup(ExerciseGroup(
                          exerciseId: exerciseBlock.exercise.exerciseId,
                          workoutId: test));
                  for (var tempExerciseSet in exerciseBlock.sets) {
                    DatabaseHelper.instance.addExerciseSet(ExerciseSet(
                        exerciseGroupId: exerciseGroupId,
                        weight: tempExerciseSet.weight,
                        reps: tempExerciseSet.reps,
                        workoutId: test));
                  }
                }
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: colors(context).accentTextColor),
              ))
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: workoutTitleController,
            decoration: const InputDecoration(hintText: 'Workout title'),
            validator: (value) {},
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exerciseBlocks.length,
              itemBuilder: (BuildContext context, int index) {
                ExerciseBlockData exerciseBlockData = exerciseBlocks[index];
                /*return Text(exerciseBlockData.exercise.name);*/
                return ExerciseBlockWidget(
                  exerciseBlockData: exerciseBlockData,
                  onChanged: (exerciseBlockData) {
                    exerciseBlocks[index] = exerciseBlockData;
                  },
                );
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
              exerciseBlocks.add(ExerciseBlockData(
                          exercise: exercise,
                          sets: List.empty(growable: true)));
                    })
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
