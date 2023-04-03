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
        title: Text(
          'Days',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              widget.onSubmit(exerciseDays);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.check_rounded,
              color: mt(context).icon.accentColor,
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
              int i = exerciseDays.indexWhere((exerciseDay) => exerciseDay.day == day);
              setState(() {
                if(i == -1) {
                  exerciseDays.add(ExerciseDay(day: day, exercises: [], exerciseBlocks: []));
                } else {
                  exerciseDays.removeAt(i);
                }
              });
            },
            leading: exerciseDays.getDays().contains(day) ? SizedBox(
              width: 32,
              child: Icon(
                Icons.check,
                color: mt(context).icon.accentColor,
              ),
            ) : const SizedBox(
              width: 32,
            ) ,
            title: Text(
              capitalize(day.name),
              style: TextStyle(
                color: mt(context).text.primaryColor,
              ),
            ),
          );
        },
      )
    );
  }
}
