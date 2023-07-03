import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/list_dialog.dart';
import 'package:maven/common/extension/extension.dart';

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../model/template.dart';
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
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  String parseMuscleCoverage(Map<Muscle, double> musclePercentages) {
    String result = '';
    musclePercentages.forEach((key, value) {
      result += '${key.name.capitalize}: ${(value * 100).truncate()}%\n';
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          Template template = state.templates.where((element) => widget.template.id == element.id).first;

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
                                    routine: template,
                                    exerciseGroups: template.exerciseGroups,
                                    onSubmit: (template, exerciseGroups) {
                                      context.read<TemplateBloc>().add(
                                        TemplateUpdate(
                                          routine: template,
                                          exerciseGroups: exerciseGroups,
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
                                      template: template,
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
                    text: 'About',
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
                              template.note,
                              style: T(context).textStyle.bodyMedium.copyWith(color: T(context).color.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
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
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    'Details',
                                    style: T(context).textStyle.titleLarge,
                                  ),
                                  Text(
                                    '',
                                    style: T(context).textStyle.titleLarge,
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Duration',
                                  ),
                                  Text(
                                    template.duration.toString(),
                                    style: T(context).textStyle.labelSmall,
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Volume',
                                  ),
                                  Text(
                                    '8,000kg',
                                    style: T(context).textStyle.labelSmall,
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Muscle Coverage',
                                  ),
                                  Text(
                                    parseMuscleCoverage(template.musclePercentages),
                                    style: T(context).textStyle.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    if(state.status.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status.isLoaded) {
                      return ListView.builder(
                        itemCount: template.exerciseGroups.length,
                        itemBuilder: (context, index) {
                          final exerciseGroup = template.exerciseGroups[index];
                          Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                exercise.name.substring(0, 1),
                              ),
                            ),
                            title: Text(
                              exercise.name,
                              style: T(context).textStyle.bodyLarge,
                            ),
                            subtitle: Text(
                              exerciseGroup.sets.length.toString(),
                              style: T(context).textStyle.bodyMedium,
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Error',
                        ),
                      );
                    }
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
                            context.read<WorkoutBloc>().add(WorkoutStart(template: template));
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
    );
  }
}
