import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/widget/active_exercise_group_widget.dart';
import 'package:Maven/screen/add_exercise_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/model/workout.dart';
import '../../../common/util/general_utils.dart';
import '../bloc/active_workout/workout_bloc.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutScreen({Key? key,
    required this.workout
  }) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
          title: "",
          context: context,
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.delete,
                  size: 26,
                  color: mt(context).icon.errorColor,
                )
            ),
            IconButton(
                onPressed: () => _pauseWorkout(context),
                icon: Icon(
                  Icons.pause,
                  size: 26,
                  color: mt(context).icon.accentColor,
                )
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.flag,
                  size: 26,
                  color: mt(context).icon.completeColor,
                )
            ),
          ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddExerciseScreen())
          ).then((value) {
            Exercise exercise = value;
            DBHelper.instance.addActiveExerciseGroup(
                ActiveExerciseGroup(
                  exerciseId: exercise.exerciseId,
                  workoutId: widget.workout.workoutId!
                )
            );
            setState(() {

            });
          });
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: mt(context).icon.accentColor,
        ),
      ),

      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        widget.workout.name,
                        style: TextStyle(
                          color: mt(context).text.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 28
                        ),
                      ),

                      SizedBox(height: 4,),

                      StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1)),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            workoutDuration(widget.workout.datetime),
                            style: TextStyle(
                                fontSize: 16,
                                color: mt(context).text.secondaryColor
                            ),
                          );
                        },
                      )

                    ],
                  ),
                ),

                FutureBuilder(
                  future: DBHelper.instance.getActiveExerciseGroupsByWorkoutId(widget.workout.workoutId!),
                  builder: (context, snapshot) {
                    List<ActiveExerciseGroup> activeExerciseGroups = snapshot.data ?? [];
                    if (!snapshot.hasData) return const Text("Loading...");
                    return ListView.builder(
                      itemCount: activeExerciseGroups.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ActiveExerciseGroupWidget(activeExerciseGroup: activeExerciseGroups[index]);
                      },
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: MFlatButton(
                    text: Text(
                      'ADD EXERCISES',
                      style: TextStyle(
                        color: mt(context).text.accentColor,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    expand: false,
                    backgroundColor: const Color(0xFFEAF5FF),
                    onPressed: () {

                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pauseWorkout(BuildContext context) {
    context.read<WorkoutBloc>().add(PauseWorkout());
    Navigator.pop(context);
  }
}


