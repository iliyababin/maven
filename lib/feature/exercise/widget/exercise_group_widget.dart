import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maven/feature/note/screen/markdown_editor.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

/// Widget for displaying an [ExerciseGroupDto] with [BaseExerciseSet]'s.
class ExerciseGroupWidget extends StatefulWidget {
  /// Creates a widget to display an [ExerciseGroupDto] with [BaseExerciseSet]'s.
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
    required this.onExerciseSetToggled,
    required this.onExerciseSetDelete,
    this.checkboxEnabled = false,
    this.hintsEnabled = false,
    this.collapsed = false,
  });

  /// [Exercise]
  final Exercise exercise;

  final bool collapsed;

  /// [ExerciseGroupDto]
  final ExerciseGroupDto exerciseGroup;

  /// The list of [BaseExerciseSet]'s within this [ExerciseGroupDto].
  final List<ExerciseSetDto> exerciseSets;

  /// The [ExerciseTimerController] for this [ExerciseGroupDto].
  final ExerciseTimerController? controller;

  /// A callback function that is called when the [ExerciseGroupDto] is updated.
  final ValueChanged<ExerciseGroupDto> onExerciseGroupUpdate;

  /// A callback function that is called when the [ExerciseGroupDto] is deleted.
  final Function() onExerciseGroupDelete;

  /// A callback function that is called when a new [BaseExerciseSet] is added.
  final ValueChanged<ExerciseSetDto> onExerciseSetAdd;

  /// A callback function that is called when an [BaseExerciseSet] is updated.
  final Function(ExerciseSetDto value, int setIndex) onExerciseSetUpdate;

  /// A callback function that is called when an [BaseExerciseSet] is deleted.
  final Function(ExerciseSetDto value, int setIndex) onExerciseSetDelete;

  /// A callback function that is called when an [BaseExerciseSet] is toggled.
  final Function(ExerciseSetDto value, int setIndex) onExerciseSetToggled;

  /// Indicates whether or not checkboxes should be enabled for the [BaseExerciseSet]'s.
  final bool checkboxEnabled;

  /// Indicates whether or not hints should be enabled for the [BaseExerciseSet]'s.
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
    return Container(
      color: T(context).color.background,
      child: Column(
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
          if (widget.exerciseGroup.notes.isNotEmpty && !widget.collapsed)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.exerciseGroup.notes.length,
              itemBuilder: (context, index) {
                final Note note = widget.exerciseGroup.notes[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: T(context).space.large,
                    top: 0,
                    bottom: 8,
                  ),
                  child: Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {

                          },
                          backgroundColor: T(context).color.error,
                          foregroundColor: T(context).color.onError,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: T(context).color.surface,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          topLeft: Radius.circular(12),
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
                                      string: note.data,
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
                              child: note.data.isNotEmpty ? Markdown(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(T(context).space.large / 2),
                                physics: const NeverScrollableScrollPhysics(),
                                data: note.data,
                              ) : Padding(
                                padding: EdgeInsets.all(T(context).space.large / 2),
                                child: Text(
                                  'Add a note',
                                  style: TextStyle(
                                    color: T(context).color.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.map_pin,
                                  color: T(context).color.primary,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          if (!widget.collapsed)
          Column(
            children: [
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
                      e.type.generateTitle(widget.exerciseGroup).toUpperCase(),
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
                              ExerciseSetDto exerciseSet = widget.exerciseSets[index];
                                widget.onExerciseSetDelete(exerciseSet, index);
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
                          group: widget.exerciseGroup,
                          exercise: widget.exercise,
                          set: widget.exerciseSets[index],
                          onExerciseSetToggled: (value) {
                            if (widget.onExerciseSetToggled != null) {
                              widget.onExerciseSetToggled!(value, index);
                              if (value.checked == true && widget.controller != null) {
                                widget.controller!.startTimer(widget.exerciseGroup.timer);
                              }
                            }
                          },
                          checkboxEnabled: widget.checkboxEnabled,
                        ));
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: TextButton.icon(
                  onPressed: () {
                    ExerciseSetDto exerciseSet = ExerciseSetDto(
                        checked: false,
                        type: ExerciseSetType.regular,
                        exerciseGroupId: widget.exerciseGroup.id ?? -1,
                        data: widget.exercise.fields.map((e) {
                          return ExerciseSetDataDto(
                            value: '',
                            fieldType: e.type,
                            exerciseSetId: -1,
                          );
                        }).toList(growable: true),
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
          )
        ],
      ),
    );
  }
}
