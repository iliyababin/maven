import 'package:Maven/feature/exercise/model/exercise_group.dart';
import 'package:flutter/material.dart';

import '../../../common/model/timed.dart';
import '../../../database/model/exercise.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../exercise/screen/exercise_selection_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';

/// Screen for creating and editing a [Template]
class EditTemplateScreen extends StatefulWidget {
  /// Creates a screen for creating and editing a [Template]
  const EditTemplateScreen({Key? key,
    this.exerciseBundles,
    required this.onSubmit,
  }) : super(key: key);

  final List<ExerciseBundle>? exerciseBundles;
  final ValueChanged<List<ExerciseBundle>> onSubmit;

  @override
  State<EditTemplateScreen> createState() => _EditTemplateScreenState();
}

class _EditTemplateScreenState extends State<EditTemplateScreen> {
  late List<ExerciseBundle> exerciseBundles;

  @override
  void initState() {
    if(widget.exerciseBundles == null) {
      exerciseBundles = [];
    } else {
      exerciseBundles = widget.exerciseBundles!.map((e) => e.copyWith()).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.exerciseBundles == null ? 'Create' : 'Edit'} Template',
        ),
        actions: [
          IconButton(
            onPressed: (){
              widget.onSubmit(exerciseBundles);
            },
            icon: const Icon(
              Icons.check_rounded,
            ),
          ),
        ],
      ),
      body: exerciseBundles.isNotEmpty ? ListView.builder(
        itemCount: exerciseBundles.length,
        itemBuilder: (context, index) {
          ExerciseBundle exerciseBlock = exerciseBundles[index];
          return ExerciseGroupWidget(
            exercise: exerciseBlock.exercise,
            exerciseGroup: exerciseBlock.exerciseGroup,
            exerciseSets: exerciseBlock.exerciseSets,
            onExerciseGroupUpdate: (value) {
              setState(() {
                exerciseBundles[index].exerciseGroup = value;
              });
            },
            onExerciseGroupDelete: () {
              setState(() {
                exerciseBundles.removeAt(index);
              });
            },
            onExerciseSetAdd: (value) {
              setState(() {
                exerciseBundles[index].exerciseSets.add(value);
              });
            },
            onExerciseSetUpdate: (value) {
              setState(() {
                int exerciseSetIndex = exerciseBundles[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                exerciseBundles[index].exerciseSets[exerciseSetIndex] = value;
              });
            },
            onExerciseSetDelete: (value) {
              setState(() {
                exerciseBundles[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
              });
            },
          );
        },
      ) : const Center(
        child: Text('Start by adding an exercise'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<Exercise>? exercises = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen()));

          for (Exercise exercise in exercises ?? []) {
            setState(() {
              exerciseBundles.add(ExerciseBundle(
                exercise: exercise,
                exerciseGroup: ExerciseGroup(
                  exerciseGroupId: DateTime.now().millisecondsSinceEpoch,
                  restTimed: Timed.zero(),
                  exerciseId: exercise.exerciseId!,
                  barId: exercise.barId,
                ),
                exerciseSets: [],
                barId: exercise.barId,
              ));
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
