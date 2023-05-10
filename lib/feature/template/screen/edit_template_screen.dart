import 'package:Maven/feature/exercise/model/exercise_group.dart';
import 'package:flutter/cupertino.dart';
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

  bool _isReorder = false;

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
              setState(() {
                _isReorder = !_isReorder;
              });
            },
            icon: Icon(
              _isReorder ? Icons.format_list_bulleted : CupertinoIcons.arrow_up_arrow_down,
              size: _isReorder ? 24 : 20,
            ),
          ),
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
      body: _isReorder ?
      ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final ExerciseBundle item = exerciseBundles.removeAt(oldIndex);
            exerciseBundles.insert(newIndex, item);
          });
        },
        proxyDecorator: (widget, index, animation) {
          return Material(
            child: widget,
            color: Colors.transparent,
          );
        },
        children: exerciseBundles.map((e) => ReorderableDragStartListener(
          key: UniqueKey(),
          index: exerciseBundles.indexOf(e),
            child: ListTile(
              title: Text(e.exercise.name),
              leading: Icon(Icons.drag_indicator_rounded),
            ),
          ),
        ).toList(),
      )
          :
      ListView.builder(
        itemCount: exerciseBundles.length,
        itemBuilder: (context, index) {
          ExerciseBundle exerciseBlock = exerciseBundles[index];
          return ExerciseGroupWidget(
            key: UniqueKey(),
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
      ),
    );
  }
}
