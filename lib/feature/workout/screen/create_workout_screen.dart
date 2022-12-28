import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/model/exercise_group.dart';
import '../../../common/model/exercise_set.dart';
import '../../../common/model/workout.dart';
import '../../../data/app_themes.dart';
import '../../../screen/add_exercise_screen.dart';
import '../../../util/database_helper.dart';
import '../../../util/provider/workout_provider.dart';
import '../../../widget/custom_app_bar.dart';
import '../model/exercise_block.dart';
import '../widget/exercise_block_widget.dart';

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
      appBar: CustomAppBar.build(
        title: "Create Workout",
        context: context,
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
      backgroundColor: colors(context).backgroundColor,
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
