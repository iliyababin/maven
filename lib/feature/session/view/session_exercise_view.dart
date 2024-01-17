import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/exercise/widget/exercise_group_detail_widget.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../theme/theme.dart';

class SessionExerciseView extends StatelessWidget {
  const SessionExerciseView({
    Key? key,
    required this.exerciseGroups,
  }) : super(key: key);

  final List<ExerciseGroupDto> exerciseGroups;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          return ListView.separated(
            itemCount: exerciseGroups.length,
            itemBuilder: (context, index) {
              ExerciseGroupDto exerciseGroup = exerciseGroups[index];
              Exercise exercise =
                  state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
              return ExerciseGroupDetailWidget(
                exercise: exercise,
                exerciseGroup: exerciseGroup,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: T(context).space.medium,
              );
            },
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
