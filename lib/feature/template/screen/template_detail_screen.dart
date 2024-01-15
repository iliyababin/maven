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

class TemplateDetailScreen extends StatefulWidget {
  const TemplateDetailScreen({
    Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends State<TemplateDetailScreen>
    with SingleTickerProviderStateMixin {
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
        Template? template = state.templates
            .where((element) => widget.template.routine.id == element.routine.id)
            .firstOrNull;
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded && template != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Template'),
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
                                  builder: (context) => RoutineEditScreen(
                                    routine: template.routine,
                                    exerciseList: template.exerciseList,
                                    onSubmit: (routine, exerciseList) {
                                      Navigator.pop(context);
                                      context.read<TemplateBloc>().add(
                                            TemplateUpdate(
                                              routine: routine,
                                              exerciseList: exerciseList,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                              );
                            },
                            leading: const Icon(Icons.edit_rounded),
                            title: const Text('Edit'),
                          ),
                          ListTile(
                            onTap: () {
                              // TODO: Implement share
                            },
                            leading: const Icon(Icons.share_rounded),
                            title: const Text('Share'),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showBottomSheetDialog(
                                context: context,
                                child: ConfirmationDialog(
                                  title: 'Delete Template',
                                  subtitle: 'This action cannot be undone.',
                                  cancelButtonStyle: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(T(context).color.onBackground),
                                  ),
                                  confirmButtonStyle: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(T(context).color.error),
                                    foregroundColor:
                                        MaterialStateProperty.all(T(context).color.onError),
                                  ),
                                  confirmText: 'Delete',
                                  onSubmit: () {
                                    context.read<TemplateBloc>().add(TemplateDelete(
                                          template: template,
                                        ));
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
                    );
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
              bottom: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Exercise'),
                  Tab(text: 'History'),
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
                              template.routine.name,
                              style: T(context).textStyle.headingLarge,
                            ),
                            if (template.routine.note.isNotEmpty)
                              MarkdownBody(
                                data: template.routine.note,
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
                          borderRadius: BorderRadius.circular(T(context).shape.large),
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
                                const Text('Est. Duration'),
                                Text(
                                  template.duration.toString(),
                                  style: T(context).textStyle.labelSmall,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Volume'),
                                Text(
                                  s(context).parseWeight(template.volume.toDouble()),
                                  style: T(context).textStyle.labelSmall,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Muscle Coverage'),
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
                        itemCount: template.exerciseList.getLength(),
                        itemBuilder: (context, index) {
                          final exerciseGroup = template.exerciseList.getExerciseGroup(index);
                          Exercise exercise = state.exercises
                              .firstWhere((element) => element.id == exerciseGroup.exerciseId);
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(exercise.name.substring(0, 1)),
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
                        child: Text('Error'),
                      );
                    }
                  },
                ),
                const Center(
                  child: Text('History'),
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
                    child: const Text('Start'),
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
              ],
            ),
          );
        }
      },
    );
  }
}
