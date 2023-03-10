import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:Maven/common/dialog/text_input_dialog.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_app_bar.dart';
import '../../exercise/dto/exercise_set.dart';
import '../../exercise/screen/add_exercise_screen.dart';
import '../../exercise/widget/exercise_group_widget.dart';
import '../bloc/template/template_bloc.dart';
import '../dto/exercise_block.dart';

class CreateTemplateScreen extends StatefulWidget {
  const CreateTemplateScreen({Key? key}) : super(key: key);

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  List<ExerciseGroup> exerciseGroups = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        title: 'Create Template',
        context: context,
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
                      exerciseGroups: exerciseGroups,
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
        itemCount: exerciseGroups.length,
        itemBuilder: (context, index) {
          return ExerciseGroupWidget(
            exercise: exerciseGroups[index].exercise,
            exerciseSets: exerciseGroups[index].exerciseSets,
            onExerciseSetAdd: () {
              setState(() {
                exerciseGroups[index].exerciseSets.add(ExerciseSet(
                    exerciseSetId: DateTime.now().millisecondsSinceEpoch,
                    option1: 0,
                    option2: exerciseGroups[index].exercise.exerciseType.exerciseTypeOption2 == null ? null : 0
                ));
              });
            },
            onExerciseSetUpdate: (value) {
              int exerciseSetIndex = exerciseGroups[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
              exerciseGroups[index].exerciseSets[exerciseSetIndex] = value;
            },
            onExerciseSetDelete: (value) {
              setState(() {
                exerciseGroups[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExerciseScreen())).then((exercise) {
            setState(() {
              exerciseGroups.add(ExerciseGroup(
                exercise: exercise,
                exerciseSets: [],
              ));
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
