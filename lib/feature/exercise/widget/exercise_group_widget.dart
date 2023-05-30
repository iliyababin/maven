import 'package:maven/feature/workout/widget/exercise_timer_widget.dart';
import 'package:flutter/material.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/exercise.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../model/exercise_group.dart';
import '../model/exercise_set.dart';
import 'exercise_group_menu.dart';
import 'exercise_set_widget.dart';

/// Widget for displaying an [ExerciseGroup] with [ExerciseSet]'s.
class ExerciseGroupWidget extends StatefulWidget {
  /// Creates a widget to display an [ExerciseGroup] with [ExerciseSet]'s.
  const ExerciseGroupWidget({super.key,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            MButton(
              onPressed: () {},
              height: 40,
              leading: const SizedBox(width: 12),
              mainAxisAlignment: MainAxisAlignment.start,
              splashColor: T(context).color.primary.withAlpha(50),
              child: Text(
                widget.exercise.name,
                style: T(context).textStyle.subtitle2,
              ),
            ),
            MButton(
              onPressed: (){
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
                    }
                  ),
                  onClose: (){}
                );
              },
              width: 45,
              height: 40,
              child: const Icon(
                Icons.more_horiz_rounded,
              ),
            )
          ],
        ),
        ActiveExerciseRow.build(
            set: Text(
              "SET",
              style: T(context).textStyle.body1.copyWith(fontSize: 13),
            ),
            previous: Text(
              "PREVIOUS",
              style: T(context).textStyle.body1.copyWith(fontSize: 13),
            ),
            option1: Text(
              widget.exercise.exerciseType.exerciseTypeOption1.value,
              style: T(context).textStyle.body1.copyWith(fontSize: 13),
            ),
            option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? Text(
              widget.exercise.exerciseType.exerciseTypeOption2!.value,
              style: T(context).textStyle.body1.copyWith(fontSize: 13),
            ) : null,
            checkbox: widget.checkboxEnabled ? Container( alignment: Alignment.center, child: const Text(''),) : null
        ),
        const SizedBox(height: 6),
        ListView.builder(
          itemCount: widget.exerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                ExerciseSet exerciseSet = widget.exerciseSets[index];
                widget.onExerciseSetDelete(exerciseSet);
              },
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
              ),
              child: ExerciseSetWidget(
                index: index + 1,
                barId: widget.exerciseGroup.barId,
                exercise: widget.exercise,
                exerciseSet: widget.exerciseSets[index],
                onExerciseSetUpdate: (value) {
                  widget.onExerciseSetUpdate(value);
                },
                onExerciseSetToggled: (value) {
                  if(widget.onExerciseSetToggled != null) {
                    widget.onExerciseSetToggled!(value);
                    if(value.checked == 1 && widget.controller != null) {
                      widget.controller!.startTimer(widget.exerciseGroup.restTimed);
                    }
                  }
                },
                checkboxEnabled: widget.checkboxEnabled,
                hintsEnabled: widget.hintsEnabled,
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: MButton(
            onPressed: () {
              ExerciseSet exerciseSet = ExerciseSet(
                exerciseSetId: DateTime.now().millisecondsSinceEpoch,
                option1: 0,
                option2: widget.exercise.exerciseType.exerciseTypeOption2 == null ? null : 0,
                checked: 0,
                exerciseGroupId: widget.exerciseGroup.exerciseGroupId,
              );
              widget.onExerciseSetAdd(exerciseSet);
            },
            expand: false,
            leading: const Icon(
              Icons.add_rounded,
            ),
            child: Text(
              'Add Set',
              style: TextStyle(
                color: T(context).color.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

      ],
    );
  }

}
