import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/common/util/i_shared_preferences.dart';
import 'package:Maven/feature/workout/widget/active_exercise_group_widget.dart';
import 'package:Maven/screen/add_exercise_screen.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../../common/model/active_workout.dart';
import '../../../common/theme/app_themes.dart';

class LogWorkoutScreen extends StatefulWidget {
  const LogWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<int>(
      preference: ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1),
      builder: (context, currentWorkoutId) {
        return CustomScaffold.build(
          context: context,
          appbar: CustomAppBar.build(
            title: "",
            context: context,
            actions: [
              TextButton(
                onPressed: (){

                },
                child: Text("Finish"),
              )
            ]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddExerciseScreen())
              ).then((value) {
                Exercise exercise = value;
                DatabaseHelper.instance.addActiveExerciseGroup(
                  ActiveExerciseGroup(
                    exerciseId: exercise.exerciseId,
                    activeWorkoutId: currentWorkoutId
                  )
                );
                setState(() {

                });
              });
            },
            backgroundColor: colors(context).popupMenuBackgroundColor,
            child: Icon(
              Icons.add,
              color: colors(context).accentTextColor,
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
                      child: FutureBuilder(
                        future: DatabaseHelper.instance.getActiveWorkout(currentWorkoutId),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData) return Text("Loading");
                          ActiveWorkout activeWorkout = snapshot.data!;
                          return Text(
                            activeWorkout.name,
                            style: TextStyle(
                                color: colors(context).primaryTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                            ),
                          );
                        },
                      ),
                    ),
                    FutureBuilder(
                      future: DatabaseHelper.instance.getActiveExerciseGroupsByActiveWorkoutId(currentWorkoutId),
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
    );
  }
}


