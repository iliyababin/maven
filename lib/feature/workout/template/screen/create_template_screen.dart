import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../common/model/template.dart';
import '../../../../screen/add_exercise_screen.dart';
import '../../../../widget/custom_app_bar.dart';
import '../bloc/template/template_bloc.dart';
import '../model/exercise_block.dart';
import '../widget/view_exercise_block_widget.dart';

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
      body: Column(
        children: [
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
          ),

          Expanded(
            child: ListView.builder(
              itemCount: exerciseBlocks.length,
              itemBuilder: (BuildContext context, int index) {
                ExerciseBlockData exerciseBlockData = exerciseBlocks[index];
                return ViewExerciseBlockWidget(
                  exerciseBlockData: exerciseBlockData,
                  onChanged: (exerciseBlockData) {
                    exerciseBlocks[index] = exerciseBlockData;
                  },
                );
              },
            ),
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
        exerciseBlocks.add(
            ExerciseBlockData(
                exercise: exercise,
                sets: List.empty(growable: true)
            )
        );
      });
    });
  }
}
