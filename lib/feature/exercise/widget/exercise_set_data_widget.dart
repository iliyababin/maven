import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../multi_keyboard/multi_keyboard.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

class ExerciseSetDataWidget extends StatefulWidget {
  const ExerciseSetDataWidget({
    Key? key,
    required this.exercise,
    required this.group,
    required this.set,
    required this.data,
    required this.isChecked,
  }) : super(key: key);

  final Exercise exercise;
  final ExerciseGroupDto group;
  final ExerciseSetDto set;
  final ExerciseSetDataDto data;
  final bool isChecked;

  @override
  State<ExerciseSetDataWidget> createState() => _ExerciseSetDataWidgetState();
}

class _ExerciseSetDataWidgetState extends State<ExerciseSetDataWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = true;
          });
          showBottomSheetDialog(
            context: context,
            child: MultiKeyboard(
              barId: widget.group.barId,
              equipment: widget.exercise.equipment,
              data: widget.data,
              onValueChanged: (value) {
                setState(() {
                  widget.data.value = value.value;
                });
              },
            ),
            onClose: () {
              setState(() {
                _isSelected = false;
              });
            },
          );
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: widget.isChecked ? T(context).color.successContainer : T(context).color.surface,
            borderRadius: BorderRadius.circular(12),
            border: _isSelected
                ? Border.all(
                    color: T(context).color.primary,
                    width: 2,
                  )
                : null,
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
