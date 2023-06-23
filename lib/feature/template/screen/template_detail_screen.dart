import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/model/exercise_bundle.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../template.dart';

class TemplateDetailScreen extends StatefulWidget {
  const TemplateDetailScreen({
    Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends State<TemplateDetailScreen> {
  void loadTemplate() => context.read<TemplateDetailBloc>().add(TemplateDetailLoad(templateId: widget.template.id!));

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
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  state.template?.name ?? 'Unknown',
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showBottomSheetDialog(
                        context: context,
                        child: Column(
                          children: [
                            MButton.tiled(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTemplateScreen(
                                      template: state.template,
                                      exerciseBundles: state.exerciseBundles,
                                      onSubmit: (template, exerciseBundles) {
                                        context.read<TemplateBloc>().add(
                                              TemplateUpdate(
                                                template: template,
                                                exerciseBundles: exerciseBundles,
                                              ),
                                            );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              leading: const Icon(
                                Icons.edit_rounded,
                              ),
                              title: 'Edit',
                            ),
                            MButton.tiled(
                              onPressed: () {},
                              leading: const Icon(
                                Icons.share_rounded,
                              ),
                              title: 'Share',
                            ),
                            MButton.tiled(
                              onPressed: () {},
                              leading: const Icon(
                                Icons.info_sharp,
                              ),
                              title: 'Info',
                            ),
                            MButton.tiled(
                              onPressed: () {
                                Navigator.pop(context);
                                showBottomSheetDialog(
                                  context: context,
                                  child: ConfirmationDialog(
                                    title: 'Delete Template',
                                    subtitle: 'This action cannot be undone',
                                    confirmButtonStyle: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(T(context).color.error),
                                      foregroundColor: MaterialStateProperty.all(T(context).color.onError),
                                    ),
                                    onSubmit: () {
                                      context.read<TemplateBloc>().add(
                                            TemplateDelete(template: state.template!),
                                          );
                                      Navigator.pop(context);
                                    },
                                  ),
                                  onClose: () {},
                                );
                              },
                              leading: Icon(
                                Icons.delete_rounded,
                                color: T(context).color.error,
                              ),
                              title: 'Delete',
                              textStyle: T(context).textStyle.bodyLarge,
                            ),
                          ],
                        ),
                        onClose: () {},
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
                    )),
                    title: Text(
                      exerciseBundle.exercise.name,
                      style: T(context).textStyle.bodyLarge,
                    ),
                    subtitle: Text(
                      exerciseBundle.exerciseSets.length.toString(),
                      style: T(context).textStyle.subtitle1,
                    ),
                  );
                },
              ),
              persistentFooterButtons: [
                Padding(
                  padding: EdgeInsets.all(T(context).padding.page),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        showBottomSheetDialog(
                          context: context,
                          child: ConfirmationDialog(
                            title: 'Start Workout',
                            subtitle: 'This will delete any current workout.',
                            confirmText: 'Start',
                            onSubmit: () {
                              context.read<WorkoutBloc>().add(WorkoutStart(template: state.template!));
                              Navigator.pop(context);
                            },
                          ),
                          onClose: () {},
                        );
                      },
                      child: const Text(
                        'Start',
                      ),
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
