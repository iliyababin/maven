import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/dialog/show_confirmation_dialog.dart';
import '../../../../common/model/exercise.dart';
import '../../../../common/model/exercise_group.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';


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
    if(context.read<WorkoutBloc>().state.status == WorkoutStatus.active) {
      bool? confirmation = await showConfirmationDialog(
        context: context,
        title: 'Workout in progress',
        subtext: 'You already have a workout in progress, would you like to delete it?'
      );
      if(confirmation ?? false) return;
      context.read<WorkoutBloc>().add(DeleteActiveWorkout());
    }
    context.read<WorkoutBloc>().add(ConvertTemplateToWorkout(template: widget.template));
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
      future: DBHelper.instance
          .getExerciseGroupsByTemplateId(widget.template.templateId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading exercises');
        List<ExerciseGroup> exerciseGroups = snapshot.data;
        return ListView.builder(
          itemCount: exerciseGroups.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ExerciseGroup exerciseGroup = exerciseGroups[index];
            return FutureBuilder(
              future:
              DBHelper.instance.getExercise(exerciseGroup.exerciseId),
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
                    future: DBHelper.instance
                        .getExerciseSetsByExerciseGroupId(
                        exerciseGroup.exerciseGroupId!),
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
