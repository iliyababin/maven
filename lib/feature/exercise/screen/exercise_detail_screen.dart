import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/complete/widget/complete_exercise_history_list_widget.dart';
import 'package:maven/main.dart';

import '../../../database/model/model.dart';
import '../bloc/exercise_bloc.dart';
import '../widget/exercise_detail_widget.dart';

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
    print('building');
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.status.isLoaded) {
          final Exercise exercise = state.exercises.firstWhere((element) => element.exerciseId == widget.exercise.exerciseId);
          
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  exercise.name,
                ),
                bottom: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      text: 'Details',
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
                  ExerciseDetailWidget(exercise: exercise),
                  CompleteExerciseHistoryListWidget(exercise: exercise),
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