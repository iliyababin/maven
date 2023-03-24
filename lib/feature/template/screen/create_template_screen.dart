import 'package:Maven/feature/exercise/model/exercise_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../theme/m_themes.dart';
import '../../exercise/model/exercise.dart';
import '../../exercise/screen/add_exercise_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';
import '../bloc/template/template_bloc.dart';
import '../dto/exercise_block.dart';

/// Screen for creating a new [Template]
class CreateTemplateScreen extends StatefulWidget {
  /// Creates a screen for creating a new [Template]
  const CreateTemplateScreen({Key? key}) : super(key: key);

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  List<ExerciseBlock> exerciseBlocks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Template',
          style: TextStyle(
            color: mt(context).text.primaryColor
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showBottomSheetDialog(
                context: context,
                child: TextInputDialog(
                  title: 'Enter a Workout Name',
                  initialValue: '',
                  keyboardType: TextInputType.name,
                  onValueSubmit: (value) {
                    context.read<TemplateBloc>().add(TemplateCreate(
                      name: value,
                      exerciseBlocks: exerciseBlocks,
                    ));
                    Navigator.pop(context);
                  },
                ),
                onClose: () {}
              );
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: mt(context).text.accentColor
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exerciseBlocks.length,
        itemBuilder: (context, index) {
          ExerciseBlock exerciseBlock = exerciseBlocks[index];
          return ExerciseGroupWidget(
            exercise: exerciseBlock.exercise,
            exerciseGroup: exerciseBlock.exerciseGroup,
            exerciseSets: exerciseBlock.exerciseSets,
            onExerciseGroupUpdate: (value) {
              setState(() {
                exerciseBlocks[index].exerciseGroup = value;
              });
            },
            onExerciseSetAdd: (value) {
              setState(() {
                exerciseBlocks[index].exerciseSets.add(value);
              });
            },
            onExerciseSetUpdate: (value) {
              setState(() {
                int exerciseSetIndex = exerciseBlocks[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                exerciseBlocks[index].exerciseSets[exerciseSetIndex] = value;
              });
            },
            onExerciseSetDelete: (value) {
              setState(() {
                exerciseBlocks[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExerciseScreen())).then((value) {
            Exercise exercise = value;
            setState(() {
              exerciseBlocks.add(ExerciseBlock(
                exercise: exercise,
                exerciseGroup: ExerciseGroup(
                  exerciseGroupId: DateTime.now().millisecondsSinceEpoch,
                  exerciseId: exercise.exerciseId,
                  barId: exercise.barId,
                ),
                exerciseSets: [],
                barId: exercise.barId
              ));
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
