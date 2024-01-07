import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../session/session.dart';
import '../../theme/theme.dart';
import '../workout.dart';

class WorkoutBarWidget extends StatelessWidget {
  const WorkoutBarWidget({
    Key? key,
    required this.workout,
    required this.exerciseTimerController,
    required this.nameNode,
    required this.reordering,
    required this.onReorder,
    required this.onAddExercises,
  }) : super(key: key);

  final Workout workout;
  final ExerciseTimerController exerciseTimerController;
  final FocusNode nameNode;
  final bool reordering;
  final Null Function() onReorder;
  final Function(List<ExerciseGroupDto> exerciseGroups) onAddExercises;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    List<Exercise>? exercises = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExerciseSelectionScreen()));
                    if (exercises != null) {
                      List<ExerciseGroupDto> exerciseGroups = exercises.map((exercise) {
                        return ExerciseGroupDto(
                          timer: exercise.timer,
                          weightUnit: exercise.weightUnit,
                          distanceUnit: exercise.distanceUnit,
                          exerciseId: exercise.id!,
                          barId: exercise.barId,
                          routineId: workout.routine.id,
                          sets: [
                            ExerciseSetDto(
                              type: ExerciseSetType.regular,
                              checked: false,
                              exerciseGroupId: -1,
                              data: exercise.fields.map((field) {
                                return ExerciseSetDataDto(
                                  value: '',
                                  fieldType: field.type,
                                  exerciseSetId: -1,
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList();
                      onAddExercises(exerciseGroups);
                    }
                  },
                  height: 40,
                  width: 40,
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
                            nameNode.requestFocus();
                          },
                          leading: const Icon(
                            Icons.edit,
                          ),
                          title: const Text('Rename'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            onReorder();
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
                                    ));
                                  Navigator.pop(context);*/
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
                                  backgroundColor: MaterialStateProperty.all(
                                      T(context).color.error),
                                  foregroundColor: MaterialStateProperty.all(
                                      T(context).color.onError),
                                ),
                                onSubmit: () {
                                  context
                                      .read<WorkoutBloc>()
                                      .add(const WorkoutDelete());
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
                  height: 40,
                  width: 40,
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
          reordering
              ? TextButton.icon(
                  onPressed: () {
                    onReorder();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        T(context).color.primaryContainer),
                    foregroundColor: MaterialStateProperty.all(
                        T(context).color.onPrimaryContainer),
                  ),
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                  label: Text(
                    'Done',
                  ),
                )
              : MButton(
                  onPressed: () {
                    context
                        .read<SessionBloc>()
                        .add(SessionAdd(workout: workout));
                    context
                        .read<WorkoutBloc>()
                        .add(WorkoutFinish(workout: workout));
                  },
                  height: 40,
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
    );
  }
}
