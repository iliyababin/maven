import 'dart:async';

import 'package:Maven/common/dialog/confirmation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/util/general_utils.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/workout.dart';
import '../../../theme/m_themes.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../exercise/screen/select_exercise_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';
import '../bloc/workout/workout_bloc.dart';
import '../bloc/workout_detail/workout_detail_bloc.dart';
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
    return BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isLoaded){
          Workout workout = state.workout!;
          List<ExerciseBundle> exerciseBundles = state.exerciseBundles;

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
                                  context.read<WorkoutDetailBloc>().add(WorkoutDetailAdd(
                                    exercise: value,
                                  ));
                                  /*context.read<WorkoutBloc>().add(WorkoutExerciseGroupAdd(exerciseGroup: ExerciseGroup(
                                    exerciseGroupId: -1,
                                    restTimed: Timed.zero(),
                                    exerciseId: exercise.exerciseId,
                                    barId: exercise.barId,
                                  )));*/
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
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showBottomSheetDialog(
                                            context: context,
                                            child: ConfirmationDialog(
                                              title: 'Delete Workout',
                                              subtitle: 'All progress will be lost.',
                                              confirmText: 'Delete',
                                              confirmColor: mt(context).color.error,
                                              onSubmit: () {
                                                context.read<WorkoutBloc>().add(WorkoutDelete(workout: workout));
                                              },
                                            ),
                                            onClose: () {  },
                                          );
                                        },
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
                              leading: Icon(
                                Icons.more_horiz,
                                color: mt(context).color.text,
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
                        onPressed: (){
                          /*context.read<WorkoutDetailBloc>().add(const WorkoutDetailUpdate(
                              exerciseBundles: [],
                          ));*/
                        },
                        height: 38,
                        width: 84,
                        backgroundColor: mt(context).color.success,
                        child: Text(
                          'Finish',
                          style: mt(context).textStyle.button1,
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
                                    style: mt(context).textStyle.heading2,
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
                          childCount: exerciseBundles.length,
                          (context, index) {
                            ExerciseBundle exerciseBundle = exerciseBundles[index];

                            return ExerciseGroupWidget(
                              exercise: exerciseBundle.exercise,
                              exerciseGroup: exerciseBundle.exerciseGroup,
                              exerciseSets: exerciseBundle.exerciseSets,
                              onExerciseGroupUpdate: (value) {
                                setState(() {
                                  exerciseBundles[index].exerciseGroup = value;
                                });
                              },
                              onExerciseGroupDelete: () {
                                setState(() {
                                  exerciseBundles.removeAt(index);
                                });
                                context.read<WorkoutDetailBloc>().add(WorkoutDetailDelete(
                                  exerciseGroup: exerciseBundle.exerciseGroup,
                                ));
                              },
                              onExerciseSetAdd: (value) {
                                setState(() {
                                  exerciseBundles[index].exerciseSets.add(value);
                                });
                                context.read<WorkoutDetailBloc>().add(WorkoutDetailAdd(
                                  exerciseSet: value,
                                ));
                              },
                              onExerciseSetUpdate: (value) {
                                setState(() {
                                  int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                                  exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
                                });
                              },
                              onExerciseSetToggled: (value) {
                                int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                                exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
                              },
                              onExerciseSetDelete: (value) {
                                setState(() {
                                  exerciseBundles[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                                });
                                context.read<WorkoutDetailBloc>().add(WorkoutDetailDelete(
                                  exerciseSet: value,
                                ));
                              },
                              checkboxEnabled: true,
                            );
                          },
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

        } else {
          return const Center(child: Text('erorr oops'));
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


