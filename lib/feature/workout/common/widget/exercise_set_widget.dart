import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../../widget/m_flat_button.dart';
import '../../template/model/exercise.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../dto/exercise_set.dart';

class ExerciseSetWidget extends StatefulWidget {

  const ExerciseSetWidget({Key? key,
    required this.index,
    required this.exercise,
    required this.exerciseSet,
    required this.onExerciseSetUpdate,
    required this.checkboxEnabled,
    required this.hintsEnabled,
  }) : super(key: key);

  final int index;

  final Exercise exercise;

  final ExerciseSet exerciseSet;

  final ValueChanged<ExerciseSet> onExerciseSetUpdate;

  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {

  static const Duration _animationSpeed = Duration(milliseconds: 250);

  bool _isChecked = false;

  final TextEditingController option1EditingController = TextEditingController();
  final TextEditingController option2EditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    option1EditingController.addListener(() {
      widget.onExerciseSetUpdate(widget.exerciseSet.copyWith(
        option1: option1EditingController.text.isEmpty ? 0 : int.parse(option1EditingController.text)
      ));
    });

    option2EditingController.addListener(() {
      widget.onExerciseSetUpdate(widget.exerciseSet.copyWith(
          option2: option2EditingController.text.isEmpty ? 0 : int.parse(option2EditingController.text)
      ));
    });

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

        option1: AnimatedContainer(
          height: 30,
          duration: _animationSpeed,
          decoration: BoxDecoration (
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: _isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor
          ),
          child: Form(
            child: TextField(
              controller: option1EditingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintsEnabled ? widget.exerciseSet.option1.toString() : '',
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),

        option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? AnimatedContainer(
          height: 30,
          duration: _animationSpeed,
          decoration: BoxDecoration (
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: _isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor
          ),
          child: Form(
            child: TextField(
              controller: option2EditingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintsEnabled ? widget.exerciseSet.option2.toString() : '',
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ) : null,

        checkbox: widget.checkboxEnabled ? SizedBox(
          height: 38,
          child: Transform.scale(
            scale: 1.8,
            child: Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(()  {
                  _isChecked = !_isChecked;
                });

               /* WorkoutExerciseSet activeExerciseSet = widget.activeExerciseSet;
                activeExerciseSet.checked = widget.activeExerciseSet.checked == 1
                    ? widget.activeExerciseSet.checked = 0
                    : widget.activeExerciseSet.checked = 1;

                context.read<WorkoutBloc>().add(UpdateActiveExerciseSet(
                    activeExerciseSet: activeExerciseSet
                ));*/
              },
              fillColor: _isChecked ? MaterialStateProperty.all<Color>(
                  const Color(0XFF2FCD71)) : MaterialStateProperty.all<Color>(mt(context).borderColor
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
