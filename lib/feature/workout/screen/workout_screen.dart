import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/util/general_utils.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/model/timed.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/exercise.dart';
import '../../../database/model/workout.dart';
import '../../../theme/m_themes.dart';
import '../../exercise/model/exercise_group.dart';
import '../../exercise/screen/select_exercise_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';
import '../bloc/active_workout/workout_bloc.dart';
import '../widget/exercise_timer_widget.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key,}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin{
  final FocusNode _workoutNameNode = FocusNode();

  ExerciseTimerController timerController = ExerciseTimerController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if(state.status == WorkoutStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.workout == null){
          return const Center(child: Text('There is no active workoout'));
        } else if (state.status == WorkoutStatus.error){
          return const Center(child: Text('erorr oops'));
        } else {
          Workout workout = state.workout!;

          return Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  decoration: BoxDecoration(
                    color: mt(context).color.background,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            MButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SelectExerciseScreen()),
                                ).then((value) async {
                                  Exercise exercise = value;
                                  context.read<WorkoutBloc>().add(WorkoutExerciseGroupAdd(exerciseGroup: ExerciseGroup(
                                    exerciseGroupId: -1,
                                    restTimed: Timed.zero(),
                                    exerciseId: exercise.exerciseId,
                                    barId: exercise.barId,
                                  )));
                                });
                              },
                              leading: Icon(
                                Icons.add_rounded,
                                color: mt(context).color.primary,
                              ),
                              height: 38,
                              width: 38,
                              backgroundColor: mt(context).color.background,
                              borderColor: mt(context).color.secondary,
                            ),
                            const SizedBox(width: 8,),
                            MButton(
                              onPressed: () {
                                showBottomSheetDialog(
                                  context: context,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MButton.tiled(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          _workoutNameNode.requestFocus();
                                        },
                                        leading: Icon(
                                          Icons.drive_file_rename_outline_rounded,
                                          color: mt(context).color.primary,
                                        ),
                                        title: 'Rename Workout',
                                      ),
                                      MButton.tiled(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          _workoutNameNode.requestFocus();
                                        },
                                        leading: Icon(
                                          CupertinoIcons.arrow_up_arrow_down,
                                          color: mt(context).color.primary,
                                        ),
                                        title: 'Reorder Exercises',
                                      ),
                                      MButton.tiled(
                                        onPressed: () {
                                          /*_pauseWorkout(context);*/
                                        },
                                        leading: Icon(
                                          Icons.pause_circle_outline_rounded,
                                          color: mt(context).color.primary,
                                        ),
                                        title: 'Pause Workout',
                                      ),
                                      MButton.tiled(
                                        onPressed: () {},
                                        leading: Icon(
                                          Icons.delete_rounded,
                                          color: mt(context).color.error,
                                        ),
                                        title: 'Discard Workout',
                                      ),

                                    ],
                                  ),
                                  onClose: () {},
                                );
                              },
                              leading: const Icon(
                                Icons.more_horiz,
                              ),
                              height: 38,
                              width: 38,
                              backgroundColor: mt(context).color.background,
                              borderColor: mt(context).color.secondary,
                            ),
                            const SizedBox(width: 8,),
                            ExerciseTimerWidget(
                              controller: timerController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8,),
                      MButton(
                        onPressed: (){},
                        height: 38,
                        width: 84,
                        backgroundColor: mt(context).flatButton.completeColor,
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: mt(context).color.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    onChanged: (value) {
                                      context.read<WorkoutBloc>().add(WorkoutUpdate(
                                        workout: workout.copyWith(name: value),
                                      ));
                                    },
                                    focusNode: _workoutNameNode,
                                    initialValue: workout.name,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: 'Workout'
                                    ),
                                    style: TextStyle(
                                      color: mt(context).color.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  StreamBuilder(
                                    stream: Stream.periodic(const Duration(seconds: 1)),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      return Text(
                                        workoutDuration(workout.timestamp),
                                        style: mt(context).textStyle.subtitle1,
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
                          childCount: state.exerciseGroups.length,
                          (context, index) => ExerciseGroupWidget(
                            exercise: state.exercises.firstWhere((exercise) => exercise.exerciseId == state.exerciseGroups[index].exerciseId),
                            exerciseGroup: state.exerciseGroups[index],
                            exerciseSets: state.exerciseSets.where((exerciseSet) => exerciseSet.exerciseGroupId == state.exerciseGroups[index].exerciseGroupId).toList(),
                            onExerciseGroupUpdate: (value) {
                              context.read<WorkoutBloc>().add(WorkoutItemsUpdate(exerciseGroups: [value]));
                            },
                            onExerciseSetAdd: (value) async {
                              context.read<WorkoutBloc>().add(WorkoutExerciseSetAdd(exerciseSet: value));
                            },
                            onExerciseSetUpdate: (value) {
                              context.read<WorkoutBloc>().add(WorkoutExerciseSetUpdate(exerciseSet: value));
                            },
                            onExerciseSetDelete: (value) {
                              context.read<WorkoutBloc>().add(WorkoutExerciseSetDelete(exerciseSet: value));
                            },
                            checkboxEnabled: true,
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                            Container(height: 100,)
                          ])
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  /*void _pauseWorkout(BuildContext context) {
    widget.isWorkoutActive(false);
    context.read<WorkoutBloc>().add(WorkoutPause());
    Navigator.pop(context);
  }*/
}


