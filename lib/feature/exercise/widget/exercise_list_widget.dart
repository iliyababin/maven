import 'package:flutter/cupertino.dart';

import '../../../database/database.dart';
import '../exercise.dart';
import '../model/exercise_list.dart';

class ExerciseListWidget extends StatefulWidget {
  const ExerciseListWidget({
    super.key,
    required this.exerciseList,
    required this.exercises,
  });

  final ExerciseList exerciseList;
  final List<Exercise> exercises;

  @override
  State<ExerciseListWidget> createState() => _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<ExerciseListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.exerciseList.getLength(),
        (context, index) {
          ExerciseGroupDto exerciseGroup = widget.exerciseList.getExerciseGroup(index);
          Exercise exercise =
              widget.exercises.firstWhere((exercise) => exercise.id == exerciseGroup.exerciseId);
          return ExerciseGroupWidget(
            key: UniqueKey(),
            exercise: exercise,
            exerciseGroup: exerciseGroup,
            exerciseSets: exerciseGroup.sets,
            onExerciseGroupUpdate: (value) {
              setState(() {
                widget.exerciseList.updateExerciseGroup(value, index);
              });
            },
            onExerciseGroupDelete: () {
              setState(() {
                widget.exerciseList.removeExerciseGroup(index);
              });
            },
            onExerciseSetAdd: (value) {
              setState(() {
                widget.exerciseList.addExerciseSet(index);
              });
            },
            onExerciseSetUpdate: (value, setIndex) {
              setState(() {
                widget.exerciseList.updateExerciseSet(value, index, setIndex);
              });
            },
            onExerciseSetDelete: (value, index2) {
              setState(() {
                widget.exerciseList.removeExerciseSet(index, index2);
              });
            },
            onExerciseSetToggled: (value, index2) {},
          );
        },
      ),
    );
  }
}
