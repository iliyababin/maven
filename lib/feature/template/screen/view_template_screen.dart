import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/m_themes.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../bloc/template/template_bloc.dart';
import '../bloc/template_detail/template_detail_bloc.dart';
import '../dto/exercise_bundle.dart';
import '../model/template.dart';
import 'edit_template_screen.dart';

class ViewTemplateScreen extends StatefulWidget {
  final Template template;

  const ViewTemplateScreen({Key? key,
    required this.template
  }) : super(key: key);

  @override
  State<ViewTemplateScreen> createState() => _ViewTemplateScreenState();
}

class _ViewTemplateScreenState extends State<ViewTemplateScreen> {
  void loadTemplate() => context.read<TemplateDetailBloc>().add(TemplateDetailLoad(templateId: widget.template.templateId!));

  @override
  void initState() {
    super.initState();
    loadTemplate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TemplateBloc, TemplateState>(
      listener: (context, state) {
        loadTemplate();
      },
      child: BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
        builder: (context, state) {
          if(state.status.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(state.status.isLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.template.name,
                  style: TextStyle(
                    color: mt(context).text.primaryColor,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTemplateScreen(
                        exerciseBundles: state.exerciseBundles,
                        onSubmit: (value) {
                          context.read<TemplateBloc>().add(TemplateUpdate(template: widget.template, exerciseBundles: value));
                          Navigator.pop(context);
                        },
                      )));
                    },
                    icon: Icon(
                      Icons.mode_edit_rounded,
                      color: mt(context).icon.accentColor,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: mt(context).icon.accentColor,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: state.exerciseBundles.length,
                itemBuilder: (context, index) {
                  ExerciseBundle exerciseBundle = state.exerciseBundles[index];
                  return ListTile(
                    title: Text(
                      exerciseBundle.exercise.name,
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                      ),
                    ),
                    subtitle: Text(
                      exerciseBundle.exerciseSets.length.toString(),
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text(
              'ERROR',
            );
          }
        },
      ),
    );
  }

  ///
  /// Functions
  ///

  void _startTemplate(BuildContext context) async {
    // TODO: Fix

    context.read<WorkoutBloc>().add(WorkoutStartTemplate(template: widget.template));
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
}
