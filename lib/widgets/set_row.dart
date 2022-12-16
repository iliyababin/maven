
import 'package:flutter/material.dart';

import '../model/exercise_set.dart';

class SetRow extends StatefulWidget {
  final ExerciseSet exerciseSet;
  final int index;

  const SetRow({Key? key, required this.exerciseSet, required this.index}) : super(key: key);

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: isChecked ? const Color(0xFF113b14) : const Color(0x00000000),
      duration: Duration(milliseconds: 150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 36,
            child: TextButton(
                onPressed: (){},
                child: Text(widget.index.toString(), style: TextStyle(color: Colors.blue))
            ),
          ),
          Container(
            width: 80,
            child: TextButton(
                onPressed: (){},
                child: Text("-")
            ),
          ),
          Container(
            width: 80,
            child: TextField(
              onTap: (){},
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration:  InputDecoration(
                  filled: true,
                  isCollapsed: true,
                  fillColor: isChecked ? const Color(0xFF113b14) : const Color(0xff282c35),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: isChecked ? const Color(0xFF113b14) : const Color(0xff282c35), width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 7), //Change this value to custom as you like
                  isDense: true, // and add this line
                  hintText: 'User Name',
                  hintStyle: TextStyle(
                    color: Color(0xFFF00),
                  )),
            ),
          ),
          Container(
            width: 80,
            child: TextField(
              onTap: (){},
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  filled: true,
                  isCollapsed: true,
                  fillColor: isChecked ? const Color(0xFF113b14) : const Color(0xff282c35),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: isChecked ? const Color(0xFF113b14) : const Color(0xff282c35), width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 7), //Change this value to custom as you like
                  isDense: true, // and add this line
                  hintText: 'User Name',
                  hintStyle: TextStyle(
                    color: Color(0xFFF00),
                  )),
            ),
          ),
          Transform.scale(
            scale: 1.8,
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: const Color(0xff282c35),
              ),
              child: Container(
                width: 30,
                child: Checkbox(
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  focusColor: Colors.red,
                  activeColor: Colors.green[900],
                  checkColor: Colors.white,
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
        ],
      ),
    );
  }
}
