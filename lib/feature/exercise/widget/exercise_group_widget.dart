import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/exercise.dart';
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
    required this.onExerciseGroupUpdate,
    required this.onExerciseSetAdd,
    required this.onExerciseSetUpdate,
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

  /// A callback function that is called when the [ExerciseGroup] is updated.
  final ValueChanged<ExerciseGroup> onExerciseGroupUpdate;

  /// A callback function that is called when a new [ExerciseSet] is added.
  final ValueChanged<ExerciseSet> onExerciseSetAdd;

  /// A callback function that is called when an [ExerciseSet] is updated.
  final ValueChanged<ExerciseSet> onExerciseSetUpdate;

  /// A callback function that is called when an [ExerciseSet] is deleted.
  final ValueChanged<ExerciseSet> onExerciseSetDelete;

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
              splashColor: mt(context).color.primary.withAlpha(50),
              child: Text(
                widget.exercise.name,
                style: mt(context).textStyle.body1,
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
              style: TextStyle(
                fontSize: 13,
                color: mt(context).color.primary,
              ),
            ),
            previous: Text(
              "PREVIOUS",
              style: TextStyle(
                  fontSize: 13,
                  color: mt(context).color.primary,
              ),
            ),
            option1: Text(
              widget.exercise.exerciseType.exerciseTypeOption1.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).color.primary,
              ),
            ),
            option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? Text(
              widget.exercise.exerciseType.exerciseTypeOption2!.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).color.primary,
              ),
            ) : null,
            checkbox: widget.checkboxEnabled ? Container( alignment: Alignment.center, child: const Text(''),) : null
        ),
        const SizedBox(height: 3),
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
                color: mt(context).color.primary,
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
