import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

class ExerciseSetWidget extends StatefulWidget {
  const ExerciseSetWidget({
    Key? key,
    required this.index,
    required this.group,
    required this.exercise,
    required this.exerciseSet,
    required this.onExerciseSetUpdate,
    this.onExerciseSetToggled,
    required this.checkboxEnabled,
    required this.hintsEnabled,
  }) : super(key: key);

  final int index;
  final ExerciseGroupDto group;
  final Exercise exercise;
  final ExerciseSetDto exerciseSet;
  final ValueChanged<ExerciseSetDto> onExerciseSetUpdate;
  final ValueChanged<ExerciseSetDto>? onExerciseSetToggled;
  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  late ExerciseSetDto exerciseSet;
  bool _isChecked = false;

  @override
  void initState() {
    exerciseSet = widget.exerciseSet;
    _isChecked = exerciseSet.checked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 44,
      color: widget.checkboxEnabled
          ? _isChecked
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
                        exerciseSet = exerciseSet.copyWith(type: exerciseSetType);
                      });
                      widget.onExerciseSetUpdate(exerciseSet.copyWith(type: exerciseSetType));
                      Navigator.pop(context);
                    },
                    leading: Container(
                      alignment: Alignment.center,
                      height: 36,
                      width: 30,
                      child: Text(
                        exerciseSetType.abbreviated,
                        style: T(context).textStyle.labelSmall.copyWith(color: exerciseSetType.color(context)),
                      ),
                    ),
                    title: Text(
                      exerciseSetType.name,
                    ),
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
            widget.exerciseSet.type == ExerciseSetType.regular ? widget.index.toString() : widget.exerciseSet.type.abbreviated,
            style: T(context).textStyle.labelSmall.copyWith(color: widget.exerciseSet.type.color(context)),
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
        options: exerciseSet.data
            .where((element) => element.fieldType != ExerciseFieldType.bodyWeight)
            .toList()
            .map((e) => ExerciseSetDataWidget(
                  isChecked: _isChecked,
                  group: widget.group,
                  exercise: widget.exercise,
                  data: e,
                  set: exerciseSet,
                  checkboxEnabled: widget.checkboxEnabled,
                  onUpdate: (value) {
                    widget.onExerciseSetUpdate(
                      value,
                    );
                  },
                ))
            .toList(),
        checkbox: widget.checkboxEnabled
            ? SizedBox(
                height: 38,
                child: Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (value) async {
                      print(value);
                      if (exerciseSet.data
                          .where((element) => element.fieldType != ExerciseFieldType.bodyWeight)
                          .toList()
                          .any((element) => element.value.isEmpty)) {
                      } else {
                        setState(() {
                          _isChecked = value!;
                        });
                        widget.onExerciseSetToggled!(
                          exerciseSet.copyWith(checked: value),
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
