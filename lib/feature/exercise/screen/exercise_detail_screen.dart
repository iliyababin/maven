import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../../main.dart';
import '../../theme/theme.dart';
import '../../session/session.dart';
import '../exercise.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  /// The [Exercise] to display
  final Exercise exercise;

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseBloc, ExerciseState>(
      listenWhen: (previous, current) {
        return previous.message != current.message;
      },
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status.isLoaded) {
          final Exercise exercise = state.exercises.firstWhere((element) => element.id == widget.exercise.id);

          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  exercise.name,
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
                                showBottomSheetDialog(
                                  context: context,
                                  child: TextInputDialog(
                                    title: 'Rename',
                                    initialValue: exercise.name,
                                    keyboardType: TextInputType.name,
                                    onValueSubmit: (value) {
                                      context.read<ExerciseBloc>().add(ExerciseUpdate(
                                        exercise: exercise.copyWith(
                                          name: value,
                                        ),
                                      ));
                                    },
                                  )
                                );
                              },
                              leading: const Icon(
                                Icons.edit,
                              ),
                              title: const Text(
                                'Rename',
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                context.read<ExerciseBloc>().add(ExerciseUpdate(
                                  exercise: exercise.copyWith(
                                    isHidden: !exercise.isHidden,
                                  ),
                                ));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              leading: Icon(
                                exercise.isHidden ? Icons.visibility : Icons.visibility_off,
                                color: exercise.isHidden ? null : T(context).color.error,
                              ),
                              title: Text(
                                exercise.isHidden ? 'Show' : 'Hide',
                                style: TextStyle(
                                  color: exercise.isHidden ? null : T(context).color.error,
                                  fontWeight: exercise.isHidden ? null : FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.more_vert_outlined,
                    ),
                  ),
                ],
                bottom: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      text: 'About',
                    ),
                    Tab(
                      text: 'History',
                    ),
                    Tab(
                      text: 'Records',
                    ),
                    Tab(
                      text: 'Charts',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: CustomScrollBehavior().getScrollPhysics(context),
                children: [
                  ExerciseDetailView(
                    exercise: exercise,
                    onModify: (exercise) {
                      context.read<ExerciseBloc>().add(ExerciseUpdate(exercise: exercise));
                    },
                  ),
                  ExerciseHistoryView(exercise: exercise),
                  ListView(),
                  ListView(),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
