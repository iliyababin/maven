import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../screen/add_exercise_screen.dart';
import '../../../../widget/custom_app_bar.dart';
import '../../common/dto/exercise_set.dart';
import '../../common/widget/exercise_group_widget.dart';
import '../bloc/template/template_bloc.dart';
import '../dto/exercise_block.dart';
import '../dto/temp_exercise_set.dart';
import '../model/template.dart';

class CreateTemplateScreen extends StatefulWidget {
  const CreateTemplateScreen({Key? key}) : super(key: key);

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  List<ExerciseBlockData> exerciseBlocks = List.empty(growable: true);
  final templateTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(

      context: context,

      appBar: CustomAppBar.build(
        title: 'Create Template',
        context: context,
        actions: [
          TextButton(
              onPressed: _createTemplate,
              child: Text(
                'Save',
                style: TextStyle(
                  color: mt(context).text.accentColor
                ),
              )
          ),
        ],
      ),

      body: CustomScrollView(
        slivers: [

          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsetsDirectional.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: templateTitleController,
                      style: TextStyle(
                          color: mt(context).text.primaryColor
                      ),
                      decoration: InputDecoration(
                        hintText: 'New Template',
                        hintStyle: TextStyle(
                            color: mt(context).textField.hintColor
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mt(context).borderColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mt(context).accentColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: exerciseBlocks.length,
              (context, index) => ExerciseGroupWidget(
                exercise: exerciseBlocks[index].exercise,
                exerciseSets: exerciseBlocks[index].sets.map((tempExerciseSet) =>
                    ExerciseSet(
                      exerciseSetId: tempExerciseSet.tempExerciseSetId,
                      option1: tempExerciseSet.option1,
                      option2: tempExerciseSet.option2,
                    )
                ).toList(growable: true),
                onExerciseSetAdd: () {
                  setState(() {
                    exerciseBlocks[index].sets.add(TempExerciseSet(tempExerciseSetId: DateTime.now().millisecondsSinceEpoch, option1: 0));
                  });
                },
                onExerciseSetUpdate: (value) {
                  int exerciseSetIndex = exerciseBlocks[index].sets.indexWhere((exerciseSet) => exerciseSet.tempExerciseSetId == value.exerciseSetId);
                  TempExerciseSet tempExerciseSet = TempExerciseSet(
                    tempExerciseSetId: value.exerciseSetId,
                    option1: value.option1,
                    option2: value.option2,
                  );
                  exerciseBlocks[index].sets[exerciseSetIndex] = tempExerciseSet;
                },
                onExerciseSetDelete: (value) {
                  setState(() {
                    exerciseBlocks[index].sets.removeWhere((exerciseSet) => exerciseSet.tempExerciseSetId == value.exerciseSetId);
                  });
                },
              ),
            )
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addExercise,
        child: const Icon(Icons.add),
      ),

    );
  }

  void _createTemplate() {
    if (templateTitleController.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter a template title'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    context.read<TemplateBloc>().add(
      TemplateAdd(
        template: Template(name: templateTitleController.text, templateFolderId: 1),
        exerciseBlocks: exerciseBlocks,
      )
    );

    Navigator.pop(context);
  }

  void _addExercise() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddExerciseScreen())
    ).then((exercise) {
      setState(() {
        List<TempExerciseSet> sets = [];
        sets.add(TempExerciseSet(tempExerciseSetId: 0, option1: 0));
        exerciseBlocks.add(
            ExerciseBlockData(
              exercise: exercise,
              sets: sets
            )
        );
      });
    });
  }
}
