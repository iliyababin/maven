import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../common/model/exercise.dart';
import '../../../common/model/exercise_group.dart';
import '../../../common/model/workout.dart';

class ViewWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const ViewWorkoutScreen({Key? key,
    required this.workout
  }) : super(key: key);

  @override
  State<ViewWorkoutScreen> createState() => _ViewWorkoutScreenState();
}

class _ViewWorkoutScreenState extends State<ViewWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: "Workout",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.workout.name),
            _listOfExercises(widget.workout.workoutId!)
          ],
        )
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('START'),
            onPressed: () => _startWorkout(context),
          ),
        )
      ],
    );
  }

  ///
  /// Functions
  ///

  void _startWorkout(BuildContext context) {
    /*if (currentWorkoutIdPref != -1) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Workout in progress'),
            content: const Text(
              'You already have a workout in progress, would you like to discard it?'
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Discard',
                  style:
                  TextStyle(
                    color: mt(context).text.errorColor
                  ),
                ),
                onPressed: () => _discardWorkout(context),
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => _cancel(context),
              ),
            ],
          );
        },
      ).then((value) async {

      });
    } else {
      context.read<ActiveWorkoutBloc>().add(ConvertTemplateToWorkout(
        workout: widget.workout
      ));
      *//*generateActiveWorkoutTemplate(context, widget.workoutId);*//*
      Navigator.pop(context);
    }*/
  }

  void _discardWorkout(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  ///
  /// Widgets
  ///

  FutureBuilder _listOfExercises(int workoutId) {
    return FutureBuilder(
      future: DBHelper.instance
          .getExerciseGroupsByWorkoutId(widget.workout.workoutId!),
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
              DBHelper.instance.getExercise(exerciseGroup.exerciseId),
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
                    future: DBHelper.instance
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
