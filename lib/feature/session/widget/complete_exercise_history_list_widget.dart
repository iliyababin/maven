import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../bloc/complete_exercise/complete_exercise_bloc.dart';
import '../model/complete_bundle.dart';
import 'complete_exercise_widget.dart';

class CompleteExerciseHistoryListWidget extends StatefulWidget {
  const CompleteExerciseHistoryListWidget({Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  State<CompleteExerciseHistoryListWidget> createState() => _CompleteExerciseHistoryListWidgetState();
}

class _CompleteExerciseHistoryListWidgetState extends State<CompleteExerciseHistoryListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CompleteExerciseBloc>().add(CompleteExerciseLoad(exerciseId: widget.exercise.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteExerciseBloc, CompleteExerciseState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          return Padding(
            padding: EdgeInsets.all(T(context).padding.page),
            child: ListView.separated(
              itemCount: state.completeBundles.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                final SessionBundle completeBundle = state.completeBundles[index];
                return CompleteExerciseWidget(
                  complete: completeBundle.session,
                  completeExerciseSets: completeBundle.sessionExerciseBundles[0].sessionExerciseSets,
                );
              },
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
