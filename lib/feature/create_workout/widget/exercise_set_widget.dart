import 'package:flutter/material.dart';

import '../model/temp_exercise_set.dart';

class ExerciseSetWidget extends StatefulWidget {
  final int index;
  final Function(TempExerciseSet) onChanged;

  const ExerciseSetWidget(
      {Key? key, required this.index, required this.onChanged})
      : super(key: key);

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.index.toString());
  }
}
