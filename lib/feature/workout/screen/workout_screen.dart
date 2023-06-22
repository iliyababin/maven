import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/confirmation_dialog.dart';

import '../../../../common/util/general_utils.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/model/timed.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/enum/weight_unit.dart';
import '../../../database/model/exercise.dart';
import '../../../database/model/exercise_group.dart';
import '../../../database/model/workout.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../exercise/screen/exercise_selection_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';
import '../../session/bloc/session_bloc/session_bloc.dart';
import '../bloc/workout/workout_bloc.dart';
import '../widget/exercise_timer_widget.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key,
    required this.workout,
    required this.exerciseBundles,
  }) : super(key: key);

  final Workout workout;
  final List<ExerciseBundle> exerciseBundles;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin{
  final FocusNode _workoutNameNode = FocusNode();

  ExerciseTimerController exerciseTimerController = ExerciseTimerController();

  late Workout workout;
  late List<ExerciseBundle> exerciseBundles = [];

  @override
  void initState() {
    workout = widget.workout;
    exerciseBundles = widget.exerciseBundles;
    super.initState();
  }

  @override
  void dispose() {
    _workoutNameNode.dispose();
    exerciseTimerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            decoration: BoxDecoration(
              color: T(context).color.background,
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: [
                      MButton(
                        onPressed: () async {
                          List<Exercise>? exercises = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen()));
                          if(exercises != null) {
                            List<ExerciseBundle> exerciseBundles1 = exercises.map((exercise) => ExerciseBundle(
                              exercise: exercise,
                              barId: exercise.barId,
                              exerciseSets: [],
                              exerciseGroup: ExerciseGroup(
                                id: DateTime.now().microsecondsSinceEpoch,
                                exerciseId: exercise.id!,
                                barId: exercise.barId,
                                timer: Timed(hour: 0, minute: 0, second: 0),
                                weightUnit: WeightUnit.lbs,
                            ))).toList();

                            setState(() {
                              exerciseBundles.addAll(exerciseBundles1);
                            });

                            context.read<WorkoutBloc>().add(WorkoutExerciseAdd(exerciseGroups: exerciseBundles1.map((e) => e.exerciseGroup).toList()));
                          }
                        },
                        height: 38,
                        width: 38,
                        backgroundColor: T(context).color.primaryContainer,
                        child: Icon(
                          Icons.add_rounded,
                          color: T(context).color.onPrimaryContainer,
                        ),
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
                                    color: T(context).color.primary,
                                  ),
                                  title: 'Rename',
                                ),
                                MButton.tiled(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    _workoutNameNode.requestFocus();
                                  },
                                  leading: Icon(
                                    CupertinoIcons.arrow_up_arrow_down,
                                    color: T(context).color.primary,
                                  ),
                                  title: 'Reorder',
                                ),
                                MButton.tiled(
                                  onPressed: () {
                                    context.read<WorkoutBloc>().add(WorkoutToggle(
                                      workout: workout.copyWith(active: false),
                                    ));
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(
                                    Icons.pause_circle_outline_rounded,
                                    color: T(context).color.primary,
                                  ),
                                  title: 'Pause',
                                ),
                                MButton.tiled(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showBottomSheetDialog(
                                      context: context,
                                      child: ConfirmationDialog(
                                        title: 'Delete',
                                        subtitle: 'All progress will be lost.',
                                        confirmText: 'Delete',
                                        confirmButtonStyle: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(T(context).color.error),
                                          foregroundColor: MaterialStateProperty.all(T(context).color.onError),
                                        ),
                                        onSubmit: () {
                                          context.read<WorkoutBloc>().add(WorkoutDelete(workout: workout));
                                        },
                                      ),
                                      onClose: () {  },
                                    );
                                  },
                                  leading: Icon(
                                    Icons.delete_rounded,
                                    color: T(context).color.error,
                                  ),
                                  title: 'Discard Workout',
                                ),

                              ],
                            ),
                            onClose: () {},
                          );
                        },
                        height: 38,
                        width: 38,
                        backgroundColor: T(context).color.surface,
                        child: Icon(
                          Icons.more_horiz,
                          color: T(context).color.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      ExerciseTimerWidget(
                              controller: exerciseTimerController,
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                MButton(
                  onPressed: (){
                    context.read<SessionBloc>().add(SessionAdd(
                      workout: workout,
                      exerciseBundles: exerciseBundles,
                    ));
                    context.read<WorkoutBloc>().add(WorkoutFinish());
                  },
                  height: 38,
                  width: 84,
                  backgroundColor: T(context).color.success,
                  child: Text(
                    'Finish',
                    style: T(context).textStyle.labelLarge.copyWith(
                      color: T(context).color.onPrimary,
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
                                context.read<WorkoutBloc>().add(WorkoutUpdate(workout: workout.copyWith(name: value)));
                              },
                              focusNode: _workoutNameNode,
                              initialValue: workout.name,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Workout',
                              ),
                              style: T(context).textStyle.headingLarge,
                            ),
                            const SizedBox(height: 4,),
                            StreamBuilder(
                              stream: Stream.periodic(const Duration(seconds: 1)),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                return Text(
                                  workoutDuration(workout.timestamp),
                                  style: T(context).textStyle.subtitle1,
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
                        controller: exerciseTimerController,
                        onExerciseGroupUpdate: (value) {
                          setState(() {
                            exerciseBundles[index].exerciseGroup = value;
                          });
                          context.read<WorkoutBloc>().add(WorkoutExerciseUpdate(exerciseGroup: value));
                        },
                        onExerciseGroupDelete: () {
                          setState(() {
                            exerciseBundles.removeAt(index);
                          });
                          context.read<WorkoutBloc>().add(WorkoutExerciseDelete(exerciseGroup: exerciseBundle.exerciseGroup));
                        },
                        onExerciseSetAdd: (value) {
                          setState(() {
                            exerciseBundles[index].exerciseSets.add(value);
                          });
                          context.read<WorkoutBloc>().add(WorkoutExerciseAdd(exerciseSets: [value]));
                        },
                        onExerciseSetUpdate: (value) {
                          setState(() {
                            int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.id == value.id);
                            exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
                          });
                          context.read<WorkoutBloc>().add(WorkoutExerciseUpdate(exerciseSet: value));
                        },
                        onExerciseSetToggled: (value) {
                          int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.id == value.id);
                          exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
                          context.read<WorkoutBloc>().add(WorkoutExerciseUpdate(exerciseSet: value));
                        },
                        onExerciseSetDelete: (value) {
                          setState(() {
                            exerciseBundles[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.id == value.id);
                          });
                          context.read<WorkoutBloc>().add(WorkoutExerciseDelete(exerciseSet: value));
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
  }

  /*void _pauseWorkout(BuildContext context) {
    widget.isWorkoutActive(false);
    context.read<WorkoutBloc>().add(WorkoutPause());
    Navigator.pop(context);
  }*/
}


