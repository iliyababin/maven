import 'package:Maven/feature/program/model/exercise_day.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../common/util/general_utils.dart';
import '../model/day.dart';

class DaySelectorScreen extends StatefulWidget {
  const DaySelectorScreen({Key? key,
    required this.exerciseDays,
    required this.onSubmit,
  }) : super(key: key);

  final List<ExerciseDay> exerciseDays;
  final ValueChanged<List<ExerciseDay>> onSubmit;

  @override
  State<DaySelectorScreen> createState() => _DaySelectorScreenState();
}

class _DaySelectorScreenState extends State<DaySelectorScreen> {
  late List<ExerciseDay> exerciseDays;

  @override
  void initState() {
    exerciseDays = List.from(widget.exerciseDays);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Days',
        ),
        actions: [
          IconButton(
            onPressed: (){
              widget.onSubmit(exerciseDays);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.check_rounded,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: Day.values.length,
        itemBuilder: (context, index) {
          Day day = Day.values[index];
          return ListTile(
            onTap: () {

            },
            trailing: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,

                  )
                ),
                value: exerciseDays.getDays().contains(day),
                onChanged: (value) {
                  int i = exerciseDays.indexWhere((exerciseDay) => exerciseDay.day == day);
                  setState(() {
                    if(i == -1) {
                      exerciseDays.add(ExerciseDay(day: day, exerciseBundles: []));
                    } else {
                      exerciseDays.removeAt(i);
                    }
                  });
                },
              ),
            ),
            title: Text(
              capitalize(day.name),
              style: mt(context).textStyle.body1,
            ),
          );
        },
      )
    );
  }
}
