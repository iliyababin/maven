import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/widget/active_exercise_group_widget.dart';
import 'package:Maven/screen/add_exercise_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../common/model/active_workout.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final ActiveWorkout activeWorkout;

  const ActiveWorkoutScreen({Key? key,
    required this.activeWorkout
  }) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
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
                onPressed: (){},
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
                  activeWorkoutId: widget.activeWorkout.activeWorkoutId!
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
                  child: Text(
                    widget.activeWorkout.name,
                    style: TextStyle(
                        color: mt(context).text.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),
                  ),
                ),
                FutureBuilder(
                  future: DBHelper.instance.getActiveExerciseGroupsByActiveWorkoutId(widget.activeWorkout.activeWorkoutId!),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}


