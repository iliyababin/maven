import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/extension.dart';
import 'package:maven/main.dart';

import '../../../database/model/model.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../complete/bloc/complete_exercise/complete_exercise_bloc.dart';
import '../../complete/model/complete_bundle.dart';
import '../../complete/widget/complete_exercise_widget.dart';
import '../bloc/exercise_bloc.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  /// The [Exercise] to display
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        final int exerciseId = exercise.exerciseId!;

        context.read<CompleteExerciseBloc>().add(CompleteExerciseLoad(exerciseId: exerciseId));

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
                ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.health_and_safety,
                          ),
                        ],
                      ),
                      title: Text(
                        'Group',
                        style: T(context).textStyle.body1,
                      ),
                      subtitle: Text(
                        exercise.muscleGroup.name.capitalize(),
                        style: T(context).textStyle.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monitor_heart,
                          ),
                        ],
                      ),
                      title: Text(
                        'Muscle',
                        style: T(context).textStyle.body1,
                      ),
                      subtitle: Text(
                        exercise.muscle.name.parseMuscleToString(),
                        style: T(context).textStyle.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category,
                          ),
                        ],
                      ),
                      title: Text(
                        'Equipment',
                        style: T(context).textStyle.body1,
                      ),
                      subtitle: Text(
                        exercise.equipment.name.capitalize(),
                        style: T(context).textStyle.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.tune,
                          ),
                        ],
                      ),
                      title: Text(
                        'Type',
                        style: T(context).textStyle.body1,
                      ),
                      subtitle: Text(
                        exercise.exerciseType.name,
                        style: T(context).textStyle.subtitle1,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<CompleteExerciseBloc, CompleteExerciseState>(
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
                            final CompleteBundle completeBundle = state.completeBundles[index];
                            return CompleteExerciseWidget(
                              complete: completeBundle.complete,
                              completeExerciseSets: completeBundle.completeExerciseBundles[0].completeExerciseSets,
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
                ),
                ListView(),
                ListView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
