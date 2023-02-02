import 'package:flutter/material.dart';

import '../dto/exercise_block.dart';
import '../dto/temp_exercise_set.dart';
import 'view_exercise_set_widget.dart';

class ViewExerciseBlockWidget extends StatefulWidget {
  final ExerciseBlockData exerciseBlockData;
  final Function(ExerciseBlockData) onChanged;

  const ViewExerciseBlockWidget(
      {Key? key, required this.exerciseBlockData, required this.onChanged})
      : super(key: key);

  @override
  State<ViewExerciseBlockWidget> createState() => _ViewExerciseBlockWidgetState();
}

class _ViewExerciseBlockWidgetState extends State<ViewExerciseBlockWidget> {
  bool hasSet = false;

  @override
  void initState() {
    super.initState();
    hasSet = widget.exerciseBlockData.sets != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.exerciseBlockData.exercise.name),
        ListView.builder(
          itemCount: widget.exerciseBlockData.sets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ViewExerciseSetWidget(
              index: index,
              onChanged: (exerciseSet) {
                widget.exerciseBlockData.sets[index] = exerciseSet;
                widget.onChanged(widget.exerciseBlockData);
              }
            );
          },
        ),
        TextButton(
          onPressed: () {
            setState(() {
              widget.exerciseBlockData.sets.add(TempExerciseSet());
            });
          },
          child: const Text("ADD SET")
        )
      ],
    );
  }

}
