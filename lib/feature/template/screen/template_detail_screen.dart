import 'package:Maven/common/dialog/confirmation_dialog.dart';
import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/m_button.dart';
import '../../../database/model/template.dart';
import '../../../theme/m_themes.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../bloc/template/template_bloc.dart';
import '../bloc/template_detail/template_detail_bloc.dart';
import 'edit_template_screen.dart';

class TemplateDetailScreen extends StatefulWidget {
  final Template template;

  const TemplateDetailScreen({Key? key,
    required this.template
  }) : super(key: key);

  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends State<TemplateDetailScreen> {
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
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      showBottomSheetDialog(
                        context: context,
                        child: Column(
                          children: [
                            MButton.tiled(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditTemplateScreen(
                                  exerciseBundles: state.exerciseBundles,
                                  onSubmit: (value) {
                                    context.read<TemplateBloc>().add(TemplateUpdate(template: widget.template, exerciseBundles: value));
                                    Navigator.pop(context);
                                  },
                                )));
                              },
                              leading: const Icon(
                                Icons.edit_rounded,
                              ),
                              title: 'Edit',
                            ),
                            MButton.tiled(
                              onPressed: (){},
                              leading: const Icon(
                                Icons.share_rounded,
                              ),
                              title: 'Share',
                            ),
                            MButton.tiled(
                              onPressed: (){},
                              leading: const Icon(
                                Icons.info_sharp,
                              ),
                              title: 'Info',
                            ),
                            MButton.tiled(
                              onPressed: (){
                                Navigator.pop(context);
                                showBottomSheetDialog(
                                  context: context,
                                  child: ConfirmationDialog(
                                    title: 'Delete Template',
                                    subtitle: 'This action cannot be undone',
                                    confirmColor: mt(context).color.error,
                                    onSubmit: () {
                                      context.read<TemplateBloc>().add(TemplateDelete(template: widget.template));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  onClose: () {},
                                );

                              },
                              leading:Icon(
                                Icons.delete_rounded,
                                color: mt(context).color.error,
                              ),
                              title: 'Delete',
                              textStyle: mt(context).textStyle.body1,
                            ),
                          ],
                        ),
                        onClose: (){},
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert_rounded,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: state.exerciseBundles.length,
                itemBuilder: (context, index) {
                  ExerciseBundle exerciseBundle = state.exerciseBundles[index];
                  return ListTile(
                    leading: CircleAvatar(
                        child: Text(
                          exerciseBundle.exercise.name.substring(0, 1),
                        )
                    ),
                    title: Text(
                      exerciseBundle.exercise.name,
                      style: mt(context).textStyle.body1,
                    ),
                    subtitle: Text(
                      exerciseBundle.exerciseSets.length.toString(),
                      style: mt(context).textStyle.subtitle1,
                    ),
                  );
                },
              ),
              persistentFooterButtons: [
                Padding(
                  padding: EdgeInsets.all(mt(context).padding.page),
                  child: MButton(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(WorkoutStart(
                        template: widget.template,
                      ));
                      Navigator.pop(context);
                    },
                    expand: false,
                    backgroundColor: mt(context).color.primary,
                    child: Text(
                      'Start',
                      style: mt(context).textStyle.button1,
                    ),
                  ),
                ),
              ],
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
}
