import 'package:flutter/material.dart';
import 'package:maven/feature/create_workout/model/exercise_block.dart';
import 'package:maven/feature/create_workout/model/temp_exercise_set.dart';
import 'package:maven/feature/create_workout/widget/exercise_set_widget.dart';

class ExerciseBlockWidget extends StatefulWidget {
  final ExerciseBlockData exerciseBlockData;
  final Function(ExerciseBlockData) onChanged;

  const ExerciseBlockWidget(
      {Key? key, required this.exerciseBlockData, required this.onChanged})
      : super(key: key);

  @override
  State<ExerciseBlockWidget> createState() => _ExerciseBlockWidgetState();
}

class _ExerciseBlockWidgetState extends State<ExerciseBlockWidget> {
  bool hasSet = false;

  @override
  void initState() {
    super.initState();
    hasSet = widget.exerciseBlockData.sets != null;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.exerciseBlockData.sets.length);

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
            return ExerciseSetWidget(
                index: index,
                onChanged: (exerciseSet) {
                  widget.exerciseBlockData.sets[index] = exerciseSet;
                  widget.onChanged(widget.exerciseBlockData);
                });
          },
        ),
        TextButton(
            onPressed: () {
              setState(() {
                widget.exerciseBlockData.sets.add(TempExerciseSet());
              });
            },
            child: const Text("ADD SET"))
      ],
    );
  }
}
