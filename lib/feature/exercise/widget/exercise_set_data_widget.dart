import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../../multi_keyboard/multi_keyboard.dart';
import '../exercise.dart';

class ExerciseSetDataWidget extends StatefulWidget {
  const ExerciseSetDataWidget({
    Key? key,
    required this.set,
    required this.group,
    required this.data,
    required this.onUpdate,
    required this.isChecked,
    required this.exercise,
    required this.checkboxEnabled,
  }) : super(key: key);

  final ExerciseSet set;
  final ExerciseGroup group;
  final ExerciseSetData data;
  final ValueChanged<ExerciseSet> onUpdate;
  final bool isChecked;
  final Exercise exercise;
  final bool checkboxEnabled;

  @override
  State<ExerciseSetDataWidget> createState() => _ExerciseSetDataWidgetState();
}

class _ExerciseSetDataWidgetState extends State<ExerciseSetDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showBottomSheetDialog(
            context: context,
            child: MultiKeyboard(
              barId: widget.group.barId,
              equipment: widget.exercise.equipment,
              data: widget.data,
              onValueChanged: (value) {
                widget.onUpdate(widget.set);
              },
            ),
            onClose: () {},
          );
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: widget.isChecked ? T(context).color.successContainer : T(context).color.surface,
            /*widget.checkboxEnabled
                ? widget.isChecked
                  ? T(context).color.successContainer
                  : T(context).color.surface
                : T(context).color.surface*/
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.data.valueAsString,
            style: T(context).textStyle.bodyLarge.copyWith(
                  color: T(context).color.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
