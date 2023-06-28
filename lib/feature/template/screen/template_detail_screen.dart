import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/list_dialog.dart';

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
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

class _TemplateDetailScreenState extends State<TemplateDetailScreen> with SingleTickerProviderStateMixin {
  void loadTemplate() => context.read<TemplateDetailBloc>().add(TemplateDetailLoad(templateId: widget.template.id!));

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
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
            Template template = state.template!;

            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'View',
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showBottomSheetDialog(
                        context: context,
                        child: ListDialog(
                          children: [
                            ListTile(
                              onTap: () {
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
                              title: const Text(
                                'Edit',
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                // TODO: Implement share
                              },
                              leading: const Icon(
                                Icons.share_rounded,
                              ),
                              title: const Text(
                                'Share',
                              ),
                            ),
                            ListTile(
                              onTap: () {
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
                                      context.read<TemplateBloc>().add(TemplateDelete(
                                            template: state.template!,
                                          ));
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
                              title: Text(
                                'Delete',
                                style: TextStyle(
                                  color: T(context).color.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                bottom: TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: 'Details',
                    ),
                    Tab(
                      text: 'Exercise',
                    ),
                    Tab(
                      text: 'History',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: tabController,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: T(context).space.large,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: T(context).space.large,
                        ),
                        Container(
                          padding: EdgeInsets.all(T(context).space.large),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: T(context).color.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.name,
                                style: T(context).textStyle.headingLarge,
                              ),
                              Text(
                                'Description',
                                style: T(context).textStyle.titleMedium,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                template.description,
                                style: T(context).textStyle.bodyMedium.copyWith(color: T(context).color.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: state.exerciseBundles.length,
                    itemBuilder: (context, index) {
                      ExerciseBundle exerciseBundle = state.exerciseBundles[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            exerciseBundle.exercise.name.substring(0, 1),
                          ),
                        ),
                        title: Text(
                          exerciseBundle.exercise.name,
                          style: T(context).textStyle.bodyLarge,
                        ),
                        subtitle: Text(
                          exerciseBundle.exerciseSets.length.toString(),
                          style: T(context).textStyle.bodyMedium,
                        ),
                      );
                    },
                  ),
                  const Center(
                    child: Text(
                      'Workout',
                    ),
                  ),
                ],
              ),
              persistentFooterButtons: [
                Padding(
                  padding: EdgeInsets.all(T(context).space.large),
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
