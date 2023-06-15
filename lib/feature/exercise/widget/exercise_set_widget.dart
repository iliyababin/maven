import 'package:flutter/material.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/exercise.dart';
import '../../../database/model/exercise_set.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../multi_keyboard/widget/multi_keyboard.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../model/set_type.dart';

class ExerciseSetWidget extends StatefulWidget {

  const ExerciseSetWidget({Key? key,
    required this.index,
    this.barId,
    required this.exercise,
    required this.exerciseSet,
    required this.onExerciseSetUpdate,
    this.onExerciseSetToggled,
    required this.checkboxEnabled,
    required this.hintsEnabled,
  }) : super(key: key);

  final int index;
  final int? barId;
  final Exercise exercise;
  final ExerciseSet exerciseSet;
  final ValueChanged<ExerciseSet> onExerciseSetUpdate;
  final ValueChanged<ExerciseSet>? onExerciseSetToggled;
  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  late ExerciseSet exerciseSet;
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
      color: _isChecked ? T(context).color.success.withAlpha(35)  : T(context).color.background,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ActiveExerciseRow.build(
        set: MButton(
          onPressed: () {
            showBottomSheetDialog(
              context: context,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: SetType.values.length,
                itemBuilder: (context, index) {
                  SetType setType = SetType.values[index];
                  return MButton.tiled(
                    onPressed: (){
                      setState(() {
                        exerciseSet = exerciseSet.copyWith(type: setType);
                      });
                      widget.onExerciseSetUpdate(exerciseSet.copyWith(type: setType));
                      Navigator.pop(context);
                    },
                    leading: Container(
                      alignment: Alignment.center,
                      height: 36,
                      width: 30,
                      child: Text(
                        setType.abbreviated,
                        style: T(context).textStyle.subtitle2.copyWith(color: setType.color(context)),
                      ),
                    ),
                    title: setType.name,
                  );
                },
              ),
              onClose: (){},
            );
          },
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          child: Text(
            widget.exerciseSet.type == SetType.regular ? widget.index.toString() : widget.exerciseSet.type.abbreviated,
            style: T(context).textStyle.subtitle2.copyWith(color: widget.exerciseSet.type.color(context)),
          ),
        ),
        previous: MButton(
          onPressed: () {},
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          child: Text(
            '-',
            style: T(context).textStyle.subtitle1,
          ),
        ),
        options: exerciseSet.data.map((e) => MButton(
          height: 30,
          expand: true,
          backgroundColor: _isChecked ? Colors.transparent : T(context).color.secondary,
          child: Text(
            e.value,
            style: T(context).textStyle.body1,
          ),
          onPressed: () {
            showBottomSheetDialog(
              context: context,
              child: MultiKeyboard(
                barId: widget.barId,
                equipment: widget.exercise.equipment,
                data: e,
                onValueChanged: (value) {
                  widget.onExerciseSetUpdate(
                    exerciseSet,
                    /*.copyWith(
                      options: exerciseSet.options.map(
                              (e) => e.id == value.id ? value : e
                      ).toList(),
                    ),*/
                  );
                },
              ),
              onClose: () {

              },
            );
          },
        )).toList(),
        checkbox: widget.checkboxEnabled ? SizedBox(
          height: 38,
          child: Transform.scale(
            scale: 1.8,
            child: Checkbox(
              value: _isChecked,
              onChanged: (value) async {
                /*  if(exerciseSet.option2 == null) {
                    if(option1EditingController.text.isEmpty) {
                      setState(() {_shake = true;});
                      await Future.delayed(const Duration(milliseconds: 500));
                      setState(() {_shake = false;});
                      return;
                    }
                  } else {
                    if(option1EditingController.text.isEmpty || option2EditingController.text.isEmpty) {
                      setState(() {_shake = true;});
                      await Future.delayed(const Duration(milliseconds: 500));
                      setState(() {_shake = false;});
                      return;
                    }
                  }*/
                //TODO WHATEVER
                /*if(exerciseSet.option1 != 0) {
                  setState(() {
                    _isChecked = !_isChecked;
                  });
                  if(widget.onExerciseSetToggled != null) {
                    widget.onExerciseSetToggled!(exerciseSet.copyWith(checked: exerciseSet.checked));
                  }
                }*/
              },
              fillColor: _isChecked ? MaterialStateProperty.all<Color>(
                  T(context).color.success) : MaterialStateProperty.all<Color>(T(context).color.secondary
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ) : null,
      ),
    );
  }
}
