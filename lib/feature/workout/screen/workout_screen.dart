import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../workout.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({
    Key? key,
    required this.workout,
  }) : super(key: key);

  final Workout workout;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin {
  final FocusNode _workoutNameNode = FocusNode();

  ExerciseTimerController exerciseTimerController = ExerciseTimerController();

  late Workout workout;

  @override
  void initState() {
    workout = widget.workout;
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
                          List<Exercise>? exercises = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen()));
                          if (exercises != null) {
                            List<ExerciseGroup> exerciseGroups = exercises.map((exercise) {
                              return ExerciseGroup(
                                id: DateTime.now().millisecondsSinceEpoch,
                                timer: exercise.timer,
                                weightUnit: exercise.weightUnit,
                                distanceUnit: exercise.distanceUnit,
                                exerciseId: exercise.id!,
                                barId: exercise.barId,
                                routineId: workout.routine.id,
                              );
                            }).toList();
                            setState(() {
                              workout = workout.copyWith(exerciseGroups: [
                                ...workout.exerciseGroups,
                                ...exerciseGroups,
                              ]);
                            });

                            // ignore: use_build_context_synchronously
                            context.read<WorkoutBloc>().add(WorkoutExerciseGroup(
                              action: ExerciseGroupAction.add,
                              exerciseGroups: exerciseGroups,
                            ));
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
                      const SizedBox(
                        width: 8,
                      ),
                      MButton(
                        onPressed: () {
                          showBottomSheetDialog(
                            context: context,
                            child: ListDialog(children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  _workoutNameNode.requestFocus();
                                },
                                leading: const Icon(
                                  Icons.edit,
                                ),
                                title: const Text('Rename'),
                              ),
                              ListTile(
                                onTap: () {},
                                leading: const Icon(
                                  Icons.filter_list,
                                ),
                                title: const Text('Reorder'),
                              ),
                              ListTile(
                                onTap: () {
                                  /*context.read<WorkoutBloc>().add(WorkoutToggle(
                                      workout: workout.copyWith(active: false),
                                    ));*/
                                  Navigator.pop(context);
                                },
                                leading: const Icon(
                                  Icons.pause_circle_outline_rounded,
                                ),
                                title: const Text('Pause'),
                              ),
                              ListTile(
                                onTap: () {
                                 /* Navigator.pop(context);
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
                                    onClose: () {},
                                  );*/
                                },
                                leading: Icon(
                                  Icons.delete_rounded,
                                  color: T(context).color.error,
                                ),
                                title: Text('Delete Workout',
                                    style: TextStyle(
                                      color: T(context).color.error,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ]),
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
                      const SizedBox(
                        width: 8,
                      ),
                      ExerciseTimerWidget(
                        controller: exerciseTimerController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                MButton(
                  onPressed: () {
                    /* context.read<SessionBloc>().add(SessionAdd(
                          workout: workout,
                          exerciseBundles: exerciseBundles,
                        ));
                    context.read<WorkoutBloc>().add(WorkoutFinish());*/
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
                            //context.read<WorkoutBloc>().add(WorkoutUpdate(workout: workout.copyWith(name: value)));
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          focusNode: _workoutNameNode,
                          initialValue: workout.routine.name,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Workout',
                          ),
                          style: T(context).textStyle.headingLarge,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            return Text(
                              workoutDuration(workout.routine.timestamp),
                              style: T(context).textStyle.bodyMedium,
                            );
                          },
                        )
                      ],
                    ),
                  )
                ])),
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state.status.isLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: workout.exerciseGroups.length,
                          (context, index) {
                            ExerciseGroup exerciseGroup = workout.exerciseGroups[index];
                            return ExerciseGroupWidget(
                              exercise: state.exercises.firstWhere((exercise) => exercise.id == exerciseGroup.exerciseId),
                              exerciseGroup: exerciseGroup,
                              exerciseSets: exerciseGroup.sets,
                              controller: exerciseTimerController,
                              onExerciseGroupUpdate: (value) {
                                setState(() {
                                  workout = workout.copyWith(exerciseGroups: workout.exerciseGroups..[index] = value);
                                });
                                context.read<WorkoutBloc>().add(WorkoutExerciseGroup(
                                      action: ExerciseGroupAction.update,
                                      exerciseGroups: [value],
                                    ));
                              },
                              onExerciseGroupDelete: () {
                                setState(() {
                                  workout = workout.copyWith(exerciseGroups: workout.exerciseGroups..removeAt(index));
                                });
                                context.read<WorkoutBloc>().add(WorkoutExerciseGroup(
                                      action: ExerciseGroupAction.delete,
                                      exerciseGroups: [exerciseGroup],
                                    ));
                              },
                              onExerciseSetAdd: (value) {},
                              onExerciseSetUpdate: (value, index) {},
                              onExerciseSetToggled: (value) {},
                              onExerciseSetDelete: (value) {},
                              checkboxEnabled: true,
                            );
                          },
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          const SizedBox(
                            height: 100,
                          ),
                          const Text('whoops.')
                        ]),
                      );
                    }
                  },
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 100,
                    )
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
