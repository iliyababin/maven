import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

class ExerciseSetWidget extends StatefulWidget {
  const ExerciseSetWidget({
    Key? key,
    required this.index,
    required this.exercise,
    required this.group,
    required this.set,
    this.onExerciseSetToggled,
    required this.checkboxEnabled,
  }) : super(key: key);

  final int index;
  final Exercise exercise;
  final ExerciseGroupDto group;
  final ExerciseSetDto set;
  final ValueChanged<ExerciseSetDto>? onExerciseSetToggled;
  final bool checkboxEnabled;

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 44,
      color: widget.checkboxEnabled
          ? widget.set.checked
              ? T(context).color.successContainer
              : T(context).color.background
          : T(context).color.background,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ExerciseRowWidget.build(
        set: MButton(
          onPressed: () {
            showBottomSheetDialog(
              context: context,
              child: ListDialog(
                children: ExerciseSetType.values.map((exerciseSetType) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        widget.set.type = exerciseSetType;
                      });
                      Navigator.pop(context);
                    },
                    leading: Container(
                      alignment: Alignment.center,
                      height: 36,
                      width: 30,
                      child: Text(
                        exerciseSetType.abbreviated,
                        style: T(context)
                            .textStyle
                            .labelSmall
                            .copyWith(color: exerciseSetType.color(context)),
                      ),
                    ),
                    title: Text(
                        exerciseSetType.name),
                  );
                }).toList(),
              ),
              onClose: () {},
            );
          },
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          child: Text(
            widget.set.type == ExerciseSetType.regular
                ? widget.index.toString()
                : widget.set.type.abbreviated,
            style: T(context).textStyle.labelSmall.copyWith(color: widget.set.type.color(context)),
          ),
        ),
        previous: MButton(
          onPressed: () {},
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          child: Text(
            '-',
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        options: widget.set.data
            .where((data) => data.fieldType != ExerciseFieldType.bodyWeight)
            .toList()
            .map(
              (data) => ExerciseSetDataWidget(
                exercise: widget.exercise,
                group: widget.group,
                set: widget.set,
                data: data,
                isChecked: widget.set.checked,
              ),
            )
            .toList(),
        checkbox: widget.checkboxEnabled
            ? SizedBox(
                height: 38,
                child: Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    value: widget.set.checked,
                    onChanged: (value) async {
                      if (widget.set.data
                          .where((element) => element.fieldType != ExerciseFieldType.bodyWeight)
                          .toList()
                          .any((element) => element.value.isEmpty)) {
                      } else {
                        setState(() {
                          widget.set.checked = value!;
                        });
                        widget.onExerciseSetToggled!(
                          widget.set.copyWith(checked: value),
                        );
                      }
                    },
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
