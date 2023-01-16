import 'dart:async';

import 'package:Maven/feature/workout/widget/active_exercise_group_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:Maven/widget/m_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/model/workout.dart';
import '../../../common/util/general_utils.dart';
import '../bloc/active_workout/workout_bloc.dart';

class WorkoutScreen extends StatefulWidget {

  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>{


  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state.status == WorkoutStatus.active) {
          Workout workout = state.workout!;

          return Expanded(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      MFlatButton(
                        onPressed: (){},
                        text: Text(
                          'Pause',
                          style: TextStyle(
                            color: mt(context).text.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        height: 38,
                        width: 80,
                        backgroundColor: mt(context).foregroundColor,
                      ),


                      MFlatButton(
                        onPressed: (){},
                        text: Text(
                          'Finish',
                          style: TextStyle(
                            color: mt(context).text.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        height: 38,
                        width: 80,
                        backgroundColor: mt(context).flatButton.completeColor,
                      )

                    ],
                  ),
                ),

                SizedBox(height: 10,),

                LinearProgressIndicator(
                ),

                Expanded(
                  child: MListView.build(
                      header:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              workout.name,
                              style: TextStyle(
                                  color: mt(context).text.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25
                              ),
                            ),

                            SizedBox(height: 4,),

                            StreamBuilder(
                              stream: Stream.periodic(Duration(seconds: 1)),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                return Text(
                                  workoutDuration(workout.datetime),
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

                      footer: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                        child: MFlatButton(
                          onPressed: () {},
                          expand: false,
                          backgroundColor: mt(context).flatButton.errorColor,
                          text: Text(
                            'Discard Workout',
                            style: TextStyle(
                                color: mt(context).text.errorColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ),

                      children: state.activeExerciseGroups.map((activeExerciseGroup) =>
                          ActiveExerciseGroupWidget(activeExerciseGroup: activeExerciseGroup)
                      ).toList()
                  ),
                )
              ],

            ),
          );

        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );

  }
    /*return CustomScaffold.build(
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
  }*/
}


