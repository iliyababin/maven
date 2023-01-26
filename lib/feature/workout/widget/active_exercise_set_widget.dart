import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/active_workout/workout_bloc.dart';

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

  GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    isChecked = widget.activeExerciseSet.checked == 1 ? true : false;
    if(widget.activeExerciseSet.weight != 0) {
      weightController.text = widget.activeExerciseSet.weight.toString();
    }
    if(widget.activeExerciseSet.reps != 0) {
      repController.text = widget.activeExerciseSet.reps.toString();
    }

    weightController.addListener(() {
      if(weightController.text == widget.activeExerciseSet.weight.toString()) return;

      if(weightController.text.isEmpty) return;
      ActiveExerciseSet activeExerciseSet = widget.activeExerciseSet;
      activeExerciseSet.weight = int.parse(weightController.text);
      context.read<WorkoutBloc>().add(UpdateActiveExerciseSet(
          activeExerciseSet: activeExerciseSet
      ));
    });
    repController.addListener(() {
      if(repController.text == widget.activeExerciseSet.reps.toString()) return;

      if(repController.text.isEmpty) return;
      ActiveExerciseSet activeExerciseSet = widget.activeExerciseSet;
      activeExerciseSet.reps = int.parse(repController.text);
      context.read<WorkoutBloc>().add(UpdateActiveExerciseSet(
          activeExerciseSet: activeExerciseSet
      ));
    });

    super.initState();
  }


  @override
  void dispose() {
    weightController.dispose();
    repController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationSpeed,
      color: isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 2),
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
              child: Text(
                widget.index.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700
                ),
              ),
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
              child: Text(
                "-",
                style: TextStyle(
                  fontSize: 15,
                  color: mt(context).text.primaryColor
                ),
              ),
            ),
          ),

          SizedBox(width: spacerSize),

          Expanded(
              child: AnimatedContainer(
                height: 30,
                duration: animationSpeed,
                decoration: BoxDecoration (
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor
                ),
                child: Form(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              )
          ),

          SizedBox(width: spacerSize),

          Expanded(
              child: AnimatedContainer(
                height: 30,
                duration: animationSpeed,
                decoration: BoxDecoration (
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isChecked ? mt(context).activeExerciseSet.completeColor : mt(context).textField.backgroundColor
                ),
                child: Form(
                  child: TextField(
                    controller: repController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              )
          ),

          SizedBox(width: spacerSize),



          SizedBox(
            height: 40,
            width: 30,
            child: Transform.scale(
              scale: 1.8,
              child: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(()  {
                     isChecked = !isChecked;
                  });

                  ActiveExerciseSet activeExerciseSet = widget.activeExerciseSet;
                  activeExerciseSet.checked = widget.activeExerciseSet.checked == 1
                      ? widget.activeExerciseSet.checked = 0
                      : widget.activeExerciseSet.checked = 1;

                  context.read<WorkoutBloc>().add(UpdateActiveExerciseSet(
                      activeExerciseSet: activeExerciseSet
                  ));
                },
                fillColor: isChecked ? MaterialStateProperty.all<Color>(
                  const Color(0XFF2FCD71)) : MaterialStateProperty.all<Color>(mt(context).borderColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          SizedBox(width: spacerSize*1.4),
        ],
      ),
    );
  }

}

