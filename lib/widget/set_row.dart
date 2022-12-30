import 'dart:developer';

import 'package:flutter/material.dart';

import '../common/model/exercise_set.dart';
import '../common/theme/app_themes.dart';

class SetRow extends StatefulWidget {

  final int index;
  final bool active;
  final ExerciseSet set;
  final Function(ExerciseSet) onChanged;

  const SetRow({Key? key, required this.index, required this.active, required this.onChanged, required this.set}) : super(key: key);

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {

  bool isChecked = false;
  bool isDisabled = true;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.set.weight != null || widget.set.reps != null){
      _weightController.text = widget.set.weight.toString() == "null" ? "": widget.set.weight.toString();
      _repsController.text = widget.set.reps.toString() == "null" ? "": widget.set.reps.toString();
    }
  }


  @override
  Widget build(BuildContext context) {

    isDisabled = false;



    return AnimatedContainer(
      color: isChecked ? colors(context).completeColor : colors(context).backgroundColor,
      duration: const Duration(milliseconds: 150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 4,
          ),
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
            width: 100,
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
              controller: _weightController,
              onTap: (){},
              onChanged: (String value) {
                setState(() {
                  widget.set.weight = int.parse(value);
                  log("Loggin weights: ${widget.set.weight}");
                  widget.onChanged(widget.set);
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
                  fillColor: isChecked
                      ? colors(context).completeColor
                      : colors(context).textFieldBackgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isChecked
                            ? colors(context).completeColor
                            : colors(context).textFieldBackgroundColor,
                        width: 0.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7),
                  //Change this value to custom as you like
                  isDense: true,
                  // and add this line
                  hintText: "",
                  hintStyle: TextStyle(
                    color: colors(context).textFieldHintColor,
                  )),
            ),
          ),
          const SizedBox(
            width: 10
          ),
          SizedBox(
            width: 80,
            child: TextField(
              onTap: (){},
              controller: _repsController,
              onChanged: (String value) {
                setState(() {
                  widget.set.reps = int.parse(value);
                  log("Loggin reps: ${widget.set.reps}");
                  widget.onChanged(widget.set);
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
                  fillColor: isChecked
                      ? colors(context).completeColor
                      : colors(context).textFieldBackgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isChecked
                            ? colors(context).completeColor
                            : colors(context).textFieldBackgroundColor,
                        width: 0.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7),
                  //Change this value to custom as you like
                  isDense: true,
                  // and add this line
                  hintText: "",
                  hintStyle: TextStyle(
                    color: colors(context).textFieldHintColor,
                  )),
            ),
          ),
          widget.active ? Transform.scale(
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
          )
              :
          Container(
            width: 100,
            alignment: Alignment.center,
            child: Icon(Icons.lock, color: colors(context).textFieldHintColor,),
          )
        ],
      ),
    );
  }
}
