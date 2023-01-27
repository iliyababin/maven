import 'package:flutter/material.dart';

import '../model/temp_exercise_set.dart';

class ViewExerciseSetWidget extends StatefulWidget {
  final int index;
  final Function(TempExerciseSet) onChanged;

  const ViewExerciseSetWidget(
      {Key? key, required this.index, required this.onChanged})
      : super(key: key);

  @override
  State<ViewExerciseSetWidget> createState() => _ViewExerciseSetWidgetState();
}

class _ViewExerciseSetWidgetState extends State<ViewExerciseSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.index.toString());
  }
}