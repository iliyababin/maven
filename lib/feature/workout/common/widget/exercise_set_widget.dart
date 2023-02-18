import 'package:Maven/common/dialog/bottom_sheet_dialog.dart';
import 'package:Maven/feature/workout/m_keyboard/widget/m_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

import '../../../../theme/m_themes.dart';
import '../../../../widget/m_flat_button.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../dto/exercise_set.dart';
import '../model/exercise.dart';

class ExerciseSetWidget extends StatefulWidget {

  ExerciseSetWidget({Key? key,
    required this.index,
    required this.exercise,
    required this.exerciseSet,
    required this.onExerciseSetUpdate,
    required this.checkboxEnabled,
    required this.hintsEnabled,
  }) : super(key: key);

  final int index;

  final Exercise exercise;

  ExerciseSet exerciseSet;

  final ValueChanged<ExerciseSet> onExerciseSetUpdate;

  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {

  static const Duration _animationSpeed = Duration(milliseconds: 250);

  bool _isChecked = false;

  final TextEditingController option2EditingController = TextEditingController();

  bool _shake = false;


  void _updateExerciseSet() {
    widget.onExerciseSetUpdate(widget.exerciseSet.copyWith(
      option2: option2EditingController.text.isEmpty ? 0 : int.parse(option2EditingController.text),
      checked: widget.checkboxEnabled ? _isChecked ? 1 : 0 : null
    ));
  }

  @override
  void initState() {
    option2EditingController.text = widget.exerciseSet.option2 == null ? '' : widget.exerciseSet.option2 == 0 ? '' : widget.exerciseSet.option2.toString();
    super.initState();
    _isChecked = widget.exerciseSet.checked == 1 ? true : false;
  }



  @override
  Widget build(BuildContext context) {

    option2EditingController.addListener(() => _updateExerciseSet());


    return AnimatedContainer(
      duration: _animationSpeed,
      height: 44,
      color: _isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ActiveExerciseRow.build(

        set: MFlatButton(
          onPressed: () {},
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          text: Text(
            widget.index.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: mt(context).text.accentColor,
            ),
          ),
        ),

        previous: MFlatButton(
          onPressed: () {

          },
          expand: false,
          height: 35,
          backgroundColor: Colors.transparent,
          text: Text(
            '-',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: mt(context).text.secondaryColor,
            ),
          ),
        ),

        option1: MFlatButton(
          height: 30,
          expand: false,
          backgroundColor: _isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor,
          text: Text(
            widget.exerciseSet.option1 == 0 ? '' : widget.exerciseSet.option1.toString(),
            style: TextStyle(
              color: mt(context).text.primaryColor
            ),
          ),
          onPressed: () {
            showBottomSheetDialog(
              context: context,
              onClose: () {
                print('closed');
              },
              height: 300,
              child: MKeyboard(
                exerciseEquipment: widget.exercise.exerciseEquipment,
                value: widget.exerciseSet.option1 == 0 ? '' : widget.exerciseSet.option1.toString(),
                onValueChanged: (p0) {
                  setState(() {
                    var nice = widget.exerciseSet.copyWith(option1: p0.isEmpty ? 0 : int.parse(p0));
                    widget.exerciseSet = nice;
                    widget.onExerciseSetUpdate(nice);

                  });
                },
              ),
            );
          },
        ),


        option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? MFlatButton(
          height: 30,
          expand: false,
          backgroundColor: _isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor,
          text: Text(
            widget.exerciseSet.option2 == 0 ? '' : widget.exerciseSet.option2.toString(),
            style: TextStyle(
                color: mt(context).text.primaryColor
            ),
          ),
          onPressed: () {
            showBottomSheetDialog(
              context: context,
              onClose: () {
                print('closed');
              },
              height: 300,
              child: MKeyboard(
                exerciseEquipment: widget.exercise.exerciseEquipment,
                value: widget.exerciseSet.option2 == 0 ? '' : widget.exerciseSet.option2.toString(),
                onValueChanged: (p0) {
                  setState(() {
                    var nice = widget.exerciseSet.copyWith(option2: p0.isEmpty ? 0 : int.parse(p0));
                    widget.exerciseSet = nice;
                    widget.onExerciseSetUpdate(nice);

                  });
                },
              ),
            );
          },
        ) : null,

        checkbox: widget.checkboxEnabled ? ShakeWidget(
          shakeConstant: ShakeHorizontalConstant2(),
          duration: const Duration(milliseconds: 2000),
          autoPlay: _shake,
          child: SizedBox(
            height: 38,
            child: Transform.scale(
              scale: 1.8,
              child: Checkbox(
                value: _isChecked,
                onChanged: (value) async {
                /*  if(widget.exerciseSet.option2 == null) {
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

                  setState(() {
                    _isChecked = !_isChecked;
                    _updateExerciseSet();
                  });



                },
                fillColor: _isChecked ? MaterialStateProperty.all<Color>(
                    const Color(0XFF2FCD71)) : MaterialStateProperty.all<Color>(mt(context).borderColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ) : null,

      ),
    );
  }
}
