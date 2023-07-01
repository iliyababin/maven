import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maven/feature/exercise/widget/note_widget.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../exercise.dart';

/// Widget for displaying an [ExerciseGroup] with [ExerciseSet]'s.
class ExerciseGroupWidget extends StatefulWidget {
  /// Creates a widget to display an [ExerciseGroup] with [ExerciseSet]'s.
  const ExerciseGroupWidget({
    super.key,
    required this.exercise,
    required this.exerciseGroup,
    required this.exerciseSets,
    this.controller,
    required this.onExerciseGroupUpdate,
    required this.onExerciseGroupDelete,
    required this.onExerciseSetAdd,
    required this.onExerciseSetUpdate,
    this.onExerciseSetToggled,
    required this.onExerciseSetDelete,
    this.checkboxEnabled = false,
    this.hintsEnabled = false,
  });

  /// [Exercise]
  final Exercise exercise;

  /// [ExerciseGroup]
  final ExerciseGroup exerciseGroup;

  /// The list of [ExerciseSet]'s within this [ExerciseGroup].
  final List<ExerciseSet> exerciseSets;

  /// The [ExerciseTimerController] for this [ExerciseGroup].
  final ExerciseTimerController? controller;

  /// A callback function that is called when the [ExerciseGroup] is updated.
  final ValueChanged<ExerciseGroup> onExerciseGroupUpdate;

  /// A callback function that is called when the [ExerciseGroup] is deleted.
  final Function() onExerciseGroupDelete;

  /// A callback function that is called when a new [ExerciseSet] is added.
  final ValueChanged<ExerciseSet> onExerciseSetAdd;

  /// A callback function that is called when an [ExerciseSet] is updated.
  final ValueChanged<ExerciseSet> onExerciseSetUpdate;

  /// A callback function that is called when an [ExerciseSet] is deleted.
  final ValueChanged<ExerciseSet> onExerciseSetDelete;

  /// A callback function that is called when an [ExerciseSet] is toggled.
  final ValueChanged<ExerciseSet>? onExerciseSetToggled;

  /// Indicates whether or not checkboxes should be enabled for the [ExerciseSet]'s.
  final bool checkboxEnabled;

  /// Indicates whether or not hints should be enabled for the [ExerciseSet]'s.
  final bool hintsEnabled;

  @override
  State<ExerciseGroupWidget> createState() => _ExerciseGroupWidgetState();
}

class _ExerciseGroupWidgetState extends State<ExerciseGroupWidget> {
  int regularIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    regularIndex = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    widget.exercise.name,
                    style: T(context).textStyle.labelLarge,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showBottomSheetDialog(
                    context: context,
                    child: ExerciseGroupMenu(
                      exercise: widget.exercise,
                      exerciseGroup: widget.exerciseGroup,
                      onExerciseGroupUpdate: (value) {
                        widget.onExerciseGroupUpdate(value);
                      },
                      onExerciseGroupDelete: () {
                        widget.onExerciseGroupDelete();
                      },
                    ),
                    onClose: () {});
              },
              icon: const Icon(
                Icons.more_horiz_rounded,
              ),
            ),
          ],
        ),
        if (widget.exerciseGroup.notes.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.exerciseGroup.notes.length,
            itemBuilder: (context, index) {
              final Note note = widget.exerciseGroup.notes[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: T(context).space.large,
                  top: 0,
                  bottom: 8,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    right: T(context).space.large,
                  ),
                  decoration: BoxDecoration(
                    color: T(context).color.surface,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    border: Border.all(
                      color: T(context).color.surface,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MarkdownEditor(
                                  note: note.data,
                                ),
                              ),
                            ).then((value) {
                              if (value != null) {
                                widget.onExerciseGroupUpdate(
                                  widget.exerciseGroup.copyWith(
                                    notes: widget.exerciseGroup.notes
                                      ..removeAt(index)
                                      ..insert(index, note.copyWith(data: value))
                                  ),
                                );
                              }
                            });
                          },
                          child: Markdown(
                            shrinkWrap: true,

                            padding: EdgeInsets.all(T(context).space.large / 2),
                            physics: const NeverScrollableScrollPhysics(),
                            data: note.data.isNotEmpty ? note.data : "Add a note...",
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              CupertinoIcons.map_pin,
                              color: T(context).color.onSurface,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ExerciseRowWidget.build(
          set: Text(
            "SET",
            style: T(context).textStyle.bodyLarge.copyWith(
                  fontSize: 13,
                  color: T(context).color.onSurfaceVariant,
                ),
          ),
          previous: Text(
            "PREVIOUS",
            style: T(context).textStyle.bodyLarge.copyWith(
                  fontSize: 13,
                  color: T(context).color.onSurfaceVariant,
                ),
          ),
          options: widget.exercise.fields
              .where((e) => e.type != ExerciseFieldType.bodyWeight)
              .toList()
              .map(
                (e) => Expanded(
                  child: Text(
                    generateTitle(e.type, widget.exerciseGroup),
                    style: T(context).textStyle.bodyLarge.copyWith(
                          fontSize: 13,
                          color: T(context).color.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
          checkbox: widget.checkboxEnabled
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.exerciseSets.where((e) => e.checked == true).length}/${widget.exerciseSets.length}',
                    style: T(context).textStyle.bodyLarge.copyWith(
                          fontSize: 13,
                          color: T(context).color.onSurfaceVariant,
                        ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 6),
        ListView.builder(
          itemCount: widget.exerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (widget.exerciseSets[index].type == ExerciseSetType.regular) {
              regularIndex++;
            }
            return Slidable(
                key: UniqueKey(),
                endActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: const ScrollMotion(),
                  children: [
                    Container(
                      height: double.infinity / 2,
                      width: 1,
                      color: T(context).color.outline,
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {},
                      padding: EdgeInsets.zero,
                      icon: Icons.timer,
                      foregroundColor: T(context).color.primary,
                      backgroundColor: T(context).color.background,
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        ExerciseSet exerciseSet = widget.exerciseSets[index];
                        widget.onExerciseSetDelete(exerciseSet);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icons.delete,
                      foregroundColor: T(context).color.error,
                      backgroundColor: T(context).color.background,
                    ),
                  ],
                ),
                child: ExerciseSetWidget(
                  index: regularIndex,
                  barId: widget.exerciseGroup.barId,
                  exercise: widget.exercise,
                  exerciseSet: widget.exerciseSets[index],
                  onExerciseSetUpdate: (value) {
                    widget.onExerciseSetUpdate(value);
                  },
                  onExerciseSetToggled: (value) {
                    if (widget.onExerciseSetToggled != null) {
                      widget.onExerciseSetToggled!(value);
                      if (value.checked == true && widget.controller != null) {
                        widget.controller!.startTimer(widget.exerciseGroup.timer);
                      }
                    }
                  },
                  checkboxEnabled: widget.checkboxEnabled,
                  hintsEnabled: widget.hintsEnabled,
                ));
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: TextButton.icon(
            onPressed: () {
              int id = DateTime.now().millisecondsSinceEpoch;
              ExerciseSet exerciseSet = ExerciseSet(
                id: id,
                checked: false,
                type: ExerciseSetType.regular,
                exerciseGroupId: widget.exerciseGroup.id!,
                data: widget.exercise.fields.map((e) {
                  return ExerciseSetData(
                    id: DateTime.now().millisecondsSinceEpoch,
                    value: '',
                    fieldType: e.type,
                    exerciseSetId: id,
                  );
                }).toList(),
              );

              widget.onExerciseSetAdd(exerciseSet);
            },
            icon: const Icon(
              Icons.add_rounded,
            ),
            label: const Text(
              'Add Set',
              style: TextStyle(
                height: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String generateTitle(ExerciseFieldType type, ExerciseGroup exerciseGroup) {
    switch (type) {
      case ExerciseFieldType.weight:
        return exerciseGroup.weightUnit!.name.toUpperCase();
      case ExerciseFieldType.reps:
        return type.name.toUpperCase();
      case ExerciseFieldType.distance:
        return exerciseGroup.distanceUnit!.name.toUpperCase();
      case ExerciseFieldType.assisted:
        return '- ${exerciseGroup.weightUnit!.name.toUpperCase()}';
      case ExerciseFieldType.weighted:
        return '+ ${exerciseGroup.weightUnit!.name.toUpperCase()}';
      case ExerciseFieldType.duration:
        return 'DURATION';
      default:
        return '';
    }
  }
}
