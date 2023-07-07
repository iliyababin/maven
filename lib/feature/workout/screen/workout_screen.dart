import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:maven/feature/note/note.dart';

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
  late final FocusNode nameNode;
  late final ExerciseTimerController exerciseTimerController;
  late final ScrollController scrollController;
  late Workout workout;

  bool isReordering = false;

  @override
  void initState() {
    nameNode = FocusNode();
    exerciseTimerController = ExerciseTimerController();
    scrollController = ScrollController();
    workout = widget.workout;
    super.initState();
  }

  @override
  void dispose() {
    nameNode.dispose();
    exerciseTimerController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          WorkoutBarWidget(
            workout: workout,
            exerciseTimerController: exerciseTimerController,
            nameNode: nameNode,
            reordering: isReordering,
            onReorder: () {
              setState(() {
                isReordering = !isReordering;
              });
            },
            onAddExercises: (exerciseGroups) {
              setState(() {
                workout = workout.copyWith(exerciseGroups: [
                  ...workout.exerciseGroups,
                  ...exerciseGroups,
                ]);
              });
              Timer(const Duration(milliseconds: 100), () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 750),
                );
              });
            },
          ),
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                if(!isReordering)
                  SliverList(
                        delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: T(context).space.medium,
                            horizontal: T(context).space.large,
                          ),
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
                                focusNode: nameNode,
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
                                height: 2,
                              ),
                              NoteWidget(
                                note: workout.routine.note,
                                onChanged: (value) {
                                  setState(() {
                                    workout = workout.copyWith(routine: workout.routine.copyWith(note: value));
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              StreamBuilder(
                                stream: Stream.periodic(const Duration(seconds: 1)),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  return Text(
                                    workoutDuration(workout.routine.timestamp),
                                    style: T(context).textStyle.labelSmall,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
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
                      if (isReordering) {
                        return SliverReorderableList(
                          itemCount: workout.exerciseGroups.length,
                          proxyDecorator: (widget, index, animation) {
                            return ProxyDecorator(widget, index, animation, context);
                          },
                          itemBuilder: (context, index) {
                            Exercise exercise = state.exercises.firstWhere((exercise) => exercise.id == workout.exerciseGroups[index].exerciseId);
                            return ReorderableDelayedDragStartListener(
                              index: index,
                              key: ValueKey(workout.exerciseGroups[index].id),
                              child: Material(
                                child: ListTile(
                                  title: Text(
                                    exercise.name,
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.close,
                                          color: T(context).color.error,
                                        ),
                                      ),
                                      ReorderableDragStartListener(
                                        index: index,
                                        child: Container(
                                          width: 30,
                                          height: 40,
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.drag_indicator_rounded,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
