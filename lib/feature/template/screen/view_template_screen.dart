import 'package:Maven/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/model/exercise.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../dao/exercise_dao.dart';
import '../dao/template_exercise_group_dao.dart';
import '../dao/template_exercise_set_dao.dart';
import '../model/template.dart';
import '../model/template_exercise_group.dart';


class ViewTemplateScreen extends StatefulWidget {
  final Template template;

  const ViewTemplateScreen({Key? key,
    required this.template
  }) : super(key: key);

  @override
  State<ViewTemplateScreen> createState() => _ViewTemplateScreenState();
}

class _ViewTemplateScreenState extends State<ViewTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: "Template",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.template.name),
            _listOfExercises(widget.template.templateId!)
          ],
        )
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('START'),
            onPressed: () => _startTemplate(context),
          ),
        )
      ],
    );
  }

  ///
  /// Functions
  ///

  void _startTemplate(BuildContext context) async {
    // TODO: Fix

    context.read<WorkoutBloc>().add(WorkoutFromTemplate(template: widget.template));
    Navigator.pop(context);
    /*if (currentTemplateIdPref != -1) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Template in progress'),
            content: const Text(
              'You already have a template in progress, would you like to discard it?'
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Discard',
                  style:
                  TextStyle(
                    color: mt(context).text.errorColor
                  ),
                ),
                onPressed: () => _discardTemplate(context),
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => _cancel(context),
              ),
            ],
          );
        },
      ).then((value) async {

      });
    } else {
      context.read<ActiveTemplateBloc>().add(ConvertTemplateToTemplate(
        template: widget.template
      ));
      *//*generateActiveTemplateTemplate(context, widget.templateId);*//*
      Navigator.pop(context);
    }*/
  }

  void _discardTemplate(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  ///
  /// Widgets
  ///

  FutureBuilder _listOfExercises(int templateId) {
    return FutureBuilder(
      future: context.read<TemplateExerciseGroupDao>().getTemplateExerciseGroupsByTemplateId(widget.template.templateId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading exercises');
        List<TemplateExerciseGroup> exerciseGroups = snapshot.data;
        return ListView.builder(
          itemCount: exerciseGroups.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            TemplateExerciseGroup exerciseGroup = exerciseGroups[index];
            return FutureBuilder(
              future: context.read<ExerciseDao>().getExercise(exerciseGroup.exerciseId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading exercise');
                Exercise exercise = snapshot.data!;
                return ListTile(
                  onTap: () {},
                  leading: Container(
                    height: 50,
                    child: Image.asset(
                      'assets/squat.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(exercise.name),
                  subtitle: FutureBuilder(
                    future: context.read<TemplateExerciseSetDao>().getTemplateExerciseSetsByTemplateExerciseGroupId(exerciseGroup.templateExerciseGroupId!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Text('Loading exercise');
                      int? length = snapshot.data?.length;
                      return Text("$length sets x 10 reps");
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
