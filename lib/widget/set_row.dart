import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';

import '../model/exercise_set.dart';

class SetRow extends StatefulWidget {
  final ExerciseSet exerciseSet;
  final int index;
  final Function(ExerciseSet) onExerciseSetChanged;

  const SetRow({Key? key, required this.exerciseSet, required this.index, required this.onExerciseSetChanged}) : super(key: key);

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {

  bool isChecked = false;
  bool isDisabled = true;
  String weight = "";
  String reps = "";

  @override
  Widget build(BuildContext context) {

    isDisabled = (weight.isEmpty || reps.isEmpty);

    return AnimatedContainer(
      color: isChecked ? colors(context).completeColor : colors(context).backgroundColor,
      duration: const Duration(milliseconds: 150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 36,
            child: TextButton(
              onPressed: (){},
              child: Text(
                widget.index.toString(),
                style: TextStyle(
                    color: colors(context).accentTextColor
                )
              )
            ),
          ),
          SizedBox(
            width: 80,
            child: TextButton(
              onPressed: (){},
              child: Text(
                "-",
                style: TextStyle(
                    color: colors(context).accentTextColor
                )
              )
            ),
          ),
          SizedBox(
            width: 80,
            child: TextField(
              onTap: (){},
              onChanged: (String value) {
                setState(() {
                  weight = value;
                });
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colors(context).primaryTextColor,
              ),
              decoration:  InputDecoration(
                  filled: true,
                  isCollapsed: true,
                  fillColor: isChecked ? colors(context).completeColor : colors(context).textFieldBackgroundColor,
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: isChecked ? colors(context).completeColor : colors(context).textFieldBackgroundColor, width: 0.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7), //Change this value to custom as you like
                  isDense: true, // and add this line
                  hintText: '0',
                  hintStyle: TextStyle(
                    color: colors(context).textFieldHintColor,
                  )),
            ),
          ),
          SizedBox(
            width: 80,
            child: TextField(
              onTap: (){},
              onChanged: (String value) {
                setState(() {
                  reps = value;
                });
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colors(context).primaryTextColor,
              ),
              decoration:  InputDecoration(
                  filled: true,
                  isCollapsed: true,
                  fillColor: isChecked ? colors(context).completeColor : colors(context).textFieldBackgroundColor,
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: isChecked ? colors(context).completeColor : colors(context).textFieldBackgroundColor, width: 0.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7), //Change this value to custom as you like
                  isDense: true, // and add this line
                  hintText: '',
                  hintStyle: TextStyle(
                    color: colors(context).textFieldHintColor,
                  )),
            ),
          ),
          Transform.scale(
            scale: 1.9,
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: colors(context).textFieldBackgroundColor,
              ),
              child: SizedBox(
                width: 30,
                child: IgnorePointer(
                  ignoring: isDisabled,
                  child: Checkbox(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                    activeColor: colors(context).completeColor,
                    checkColor: colors(context).checkColor,
                    value: isChecked,

                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
