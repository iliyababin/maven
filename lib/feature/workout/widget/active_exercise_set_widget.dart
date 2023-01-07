import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveExerciseSetWidget extends StatefulWidget {
  const ActiveExerciseSetWidget({Key? key, required this.activeExerciseSet, required this.index}) : super(key: key);

  final ActiveExerciseSet activeExerciseSet;
  final int index;
  
  @override
  State<ActiveExerciseSetWidget> createState() => _ActiveExerciseSetWidgetState();
}

class _ActiveExerciseSetWidgetState extends State<ActiveExerciseSetWidget> {

  bool isChecked = false;
  double spacerSize = 10;
  Duration animationSpeed = const Duration(milliseconds: 250);
  TextEditingController weightController = TextEditingController();
  TextEditingController repController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationSpeed,
      color: isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: spacerSize),
          SizedBox(
            width: 35,
            height: 35,
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(7)
                  )
                )
              ),
              child: Text(widget.index.toString()),
            ),
          ),
          SizedBox(width: spacerSize),
          SizedBox(
            width: 90,
            height: 35,
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(7)
                      )
                  )
              ),
              child: const Text("-"),
            ),
          ),
          SizedBox(width: spacerSize),
          customTextField(
            controller: weightController,
            isChecked: isChecked,
          ),
          SizedBox(width: spacerSize),
          customTextField(
            controller: repController,
            isChecked: isChecked
          ),
          SizedBox(width: spacerSize),
          SizedBox(
            height: 40,
            width: 30,
            child: Transform.scale(
              scale: 1.65,
              child: Checkbox(
                value: isChecked,

                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                fillColor: isChecked ? MaterialStateProperty.all<Color>(
                  const Color(0XFF2FCD71)) : MaterialStateProperty.all<Color>(mt(context).borderColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(width: spacerSize*1.4),
        ],
      ),
    );
  }

  Expanded customTextField({required TextEditingController controller, required bool isChecked}) {
    return Expanded(
        child: AnimatedContainer(
          height: 30,
          duration: animationSpeed,
          decoration: BoxDecoration (
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).backgroundColor
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '',
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        )
    );
  }
}