/*
*

*/
import 'dart:async';

import 'package:Maven/feature/workout/widget/active_exercise_group_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/model/exercise.dart';
import '../../../common/model/workout.dart';
import '../../../common/util/general_utils.dart';
import '../../../screen/add_exercise_screen.dart';
import '../bloc/active_workout/workout_bloc.dart';

class WorkoutScreen extends StatefulWidget {

  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin{

  Timer _timer = Timer(Duration(seconds: 30), () { });
  int _originalTime = 30;
  int _timeLeft = 30;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state.status == WorkoutStatus.active) {
          Workout workout = state.workout!;

          return Expanded(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(
                        child: Row(
                          children: [
                            MFlatButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.add_rounded,
                                size: 30,
                                color: mt(context).text.whiteColor,
                              ),
                              height: 38,
                              width: 38,
                              backgroundColor: mt(context).accentColor,
                            ),

                            const SizedBox(width: 8,),

                            MFlatButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.more_horiz,
                                size: 25,
                                color: mt(context).text.primaryColor,
                              ),
                              height: 38,
                              width: 38,
                              backgroundColor: mt(context).foregroundColor,
                            ),

                            const SizedBox(width: 8,),

                            _timeLeft != 0 ?
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadiusDirectional.circular(8),
                                child: Container(
                                  height: 38,
                                  child: Stack(
                                    children: [

                                      LinearProgressIndicator(
                                        backgroundColor: mt(context).foregroundColor,
                                        color: mt(context).accentColor,
                                        value: _timeLeft / _originalTime,
                                        minHeight: 38,
                                       ),
                                      Center(
                                        child: Text(
                                          _timeLeft.toString(),
                                          style: TextStyle(
                                            color: mt(context).text.primaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            :
                            MFlatButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.timer,
                                size: 25,
                                color: mt(context).text.primaryColor,
                              ),
                              height: 38,
                              width: 38,
                              backgroundColor: mt(context).foregroundColor,
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(width: 8,),

                      MFlatButton(
                        onPressed: (){
                          _startTimer(35);
                          /*setState(() {
                            timerActive = !timerActive;
                          });*/
                        },
                        text: Text(
                          'Finish',
                          style: TextStyle(
                            color: mt(context).text.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        height: 38,
                        width: 84,
                        backgroundColor: mt(context).flatButton.completeColor,
                      ),
                    ],
                  ),
                ),

                const LinearProgressIndicator(),

                /*TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(seconds: 25),
                  builder: (context, value, _) => LinearProgressIndicator(value: value),
                ),*/

                Expanded(
                  child: CustomScrollView(
                    slivers: [

                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 25, 15, 12),
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

                                const SizedBox(height: 4,),

                                StreamBuilder(
                                  stream: Stream.periodic(const Duration(seconds: 1)),
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
                          )
                        ])
                      ),

                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.activeExerciseGroups.length,
                          (context, index) {
                            return ActiveExerciseGroupWidget(
                              activeExerciseGroup: state.activeExerciseGroups[index]
                            );
                          }
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 30, 15, 60),
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
                        ])
                      )

                    ],
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

  ///
  /// Functions
  ///

  void _startTimer (int seconds) {
    _originalTime = seconds;
    _timeLeft = seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _addExercises () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseScreen())
    ).then((value) {
      Exercise exercise = value;
      context.read<WorkoutBloc>().add(
        AddExercise(
          exercise: exercise
        )
      );

    });
  }

  void _pauseWorkout(BuildContext context) {
    context.read<WorkoutBloc>().add(PauseWorkout());
    Navigator.pop(context);
  }
}
