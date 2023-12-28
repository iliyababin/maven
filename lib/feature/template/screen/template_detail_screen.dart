import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../../workout/bloc/workout/workout_bloc.dart';
import '../template.dart';
import '../view/template_options_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        List<Template> templates = state.templates.where((element) => widget.template.id == element.id).toList();
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded && templates.isNotEmpty) {
          Template template = templates.first;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Template',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showTemplateOptionsView(context, template);
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
                            if (template.note.isNotEmpty)
                              MarkdownBody(
                                data: template.note,
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
                          defaultVerticalAlignment: TableCellVerticalAlignment.top,
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
                                  'Est. Duration',
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
                                  '${s(context).parseWeight(template.volume.toDouble())}',
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
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
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
                    'History',
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
                            context.read<WorkoutBloc>().add(WorkoutStart(template));
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
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Not Found',
                    style: T(context).textStyle.titleLarge,
                  ),
                ),
                SizedBox(
                  height: T(context).space.large,
                ),
                Center(
                  child: Container(
                    width: 300,
                    child: const Text(
                      'The template was either deleted or does not exist.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
