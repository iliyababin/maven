import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../../session/session.dart';
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

  bool isEditing = false;

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
                                timer: exercise.timer,
                                weightUnit: exercise.weightUnit,
                                distanceUnit: exercise.distanceUnit,
                                exerciseId: exercise.id!,
                                barId: exercise.barId,
                                routineId: workout.routine.id,
                                sets: [
                                  ExerciseSet(
                                    type: ExerciseSetType.regular,
                                    checked: false,
                                    exerciseGroupId: -1,
                                    data: exercise.fields.map((field) {
                                      return ExerciseSetData(
                                        value: '',
                                        fieldType: field.type,
                                        exerciseSetId: -1,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            }).toList();
                            setState(() {
                              workout = workout.copyWith(exerciseGroups: [
                                ...workout.exerciseGroups,
                                ...exerciseGroups,
                              ]);
                            });
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
                                onTap: () {
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                },
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
                                        context.read<WorkoutBloc>().add(const WorkoutDelete());
                                      },
                                    ),
                                  );
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
                    // TODO: ship data to session
                    context.read<SessionBloc>().add(SessionAdd(workout: workout));
                    exerciseTimerController.dispose();
                    context.read<WorkoutBloc>().add(WorkoutFinish(workout: workout));
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
                !isEditing
                    ? SliverList(
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
                      ]))
                    : SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: FilledButton(
                              onPressed: (){

                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(T(context).color.errorContainer),
                                foregroundColor: MaterialStateProperty.all(T(context).color.onErrorContainer),
                              ),
                              child: Text(
                                'Cancel',
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: FilledButton.icon(
                              onPressed: (){

                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(T(context).color.primaryContainer),
                                foregroundColor: MaterialStateProperty.all(T(context).color.onPrimaryContainer),
                              ),
                              label: Text(
                                'Save',
                              ),
                              icon: Icon(
                                Icons.check_rounded,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state.status.isLoaded) {
                      if (isEditing) {
                        return SliverReorderableList(
                          itemCount: workout.exerciseGroups.length,
                          proxyDecorator: (widget, index, animation) {
                            return ProxyDecorator(widget, index, animation, context);
                          },
                          itemBuilder: (context, index) {
                            return ReorderableDelayedDragStartListener(
                              index: index,
                              key: ValueKey(workout.exerciseGroups[index].id),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: T(context).space.large,
                                  vertical: T(context).space.medium,
                                ),
                                color: T(context).color.background,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(state.exercises.firstWhere((exercise) => exercise.id == workout.exerciseGroups[index].exerciseId).name),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.close,
                                          ),
                                          constraints: const BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                          color: T(context).color.error,
                                        ),
                                        SizedBox(
                                          width: T(context).space.medium,
                                        ),
                                        ReorderableDragStartListener(
                                          index: index,
                                          child: const Icon(
                                            Icons.drag_indicator_rounded,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onReorder: (oldIndex, newIndex) {},
                        );
                      }

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
                              },
                              onExerciseGroupDelete: () {
                                setState(() {
                                  workout = workout.copyWith(exerciseGroups: workout.exerciseGroups..removeAt(index));
                                });
                              },
                              onExerciseSetAdd: (value) {
                                setState(() {
                                  workout = workout.copyWith(
                                      exerciseGroups: workout.exerciseGroups..[index] = exerciseGroup.copyWith(sets: exerciseGroup.sets..add(value)));
                                });
                              },
                              onExerciseSetUpdate: (value, index2) {
                                setState(() {
                                  workout = workout.copyWith(
                                      exerciseGroups: workout.exerciseGroups..[index] = exerciseGroup.copyWith(sets: exerciseGroup.sets..[index2] = value));
                                });
                              },
                              onExerciseSetToggled: (value, index2) {
                                workout = workout.copyWith(
                                    exerciseGroups: workout.exerciseGroups..[index] = exerciseGroup.copyWith(sets: exerciseGroup.sets..[index2] = value));
                              },
                              onExerciseSetDelete: (value, index2) {
                                setState(() {
                                  workout = workout.copyWith(
                                      exerciseGroups: workout.exerciseGroups..[index] = exerciseGroup.copyWith(sets: exerciseGroup.sets..removeAt(index2)));
                                });
                              },
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
