import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/list_dialog.dart';
import 'package:maven/common/extension.dart';

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

  String muscleCoverage(Template template) {
    String muscleCoverage = '';
    HashMap<Muscle, int> muscles = HashMap();

    for(TemplateExerciseGroup exerciseGroup in template.exerciseGroups) {
      if(muscles.containsKey(exerciseGroup.exercise.muscle)){
        muscles[exerciseGroup.exercise.muscle] = muscles[exerciseGroup.exercise.muscle]! + 1;
      } else {
        muscles[exerciseGroup.exercise.muscle] = 1;
      }
    }

    for(Muscle muscle in muscles.keys) {
      muscleCoverage += '${(muscles[muscle]! / template.exerciseGroups.length * 100).truncate()}% ${muscle.name.capitalize()} \n';
    }
    return muscleCoverage;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        print('ne');

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
                                    template: template,
                                    exerciseBundles: template.exerciseGroups.map((e) => ExerciseBundle(
                                      exercise: e.exercise,
                                      exerciseSets: e.exerciseSets,
                                      exerciseGroup: e,
                                      barId: e.barId,
                                    )).toList(),
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
                              template.description,
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
                                    '1hr 5min',
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
                                    muscleCoverage(template),
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
                ListView.builder(
                  itemCount: template.exerciseGroups.length,
                  itemBuilder: (context, index) {
                    TemplateExerciseGroup exerciseGroup = template.exerciseGroups[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          exerciseGroup.exercise.name.substring(0, 1),
                        ),
                      ),
                      title: Text(
                        exerciseGroup.exercise.name,
                        style: T(context).textStyle.bodyLarge,
                      ),
                      subtitle: Text(
                        exerciseGroup.exerciseSets.length.toString(),
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
