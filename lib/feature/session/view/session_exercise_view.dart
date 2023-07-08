import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';

class SessionExerciseView extends StatelessWidget {
  const SessionExerciseView({
    Key? key,
    required this.exerciseGroups,
  }) : super(key: key);

  final List<ExerciseGroup> exerciseGroups;

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
              ExerciseGroup exerciseGroup = exerciseGroups[index];
              Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
              return Container(
                padding: EdgeInsets.all(T(context).space.large),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(T(context).shape.large),
                  color: T(context).color.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: T(context).textStyle.titleLarge,
                    ),
                    Table(
                      children: List.generate(
                        exerciseGroup.sets.length + 1,
                        (index) {
                          index = index - 1;
                          if (index == -1) {
                            return TableRow(
                              children: List.generate(
                                exerciseGroup.sets.first.data.length + 1,
                                (index) {
                                  index = index - 1;
                                  if (index == -1) {
                                    return Text(
                                      'Set',
                                      style: T(context).textStyle.titleSmall,
                                    );
                                  }
                                  ExerciseSetData data = exerciseGroup.sets.first.data[index];
                                  return Text(
                                    data.fieldType.generateTitle(exerciseGroup),
                                    style: T(context).textStyle.titleSmall,
                                  );
                                },
                              ),
                            );
                          }
                          ExerciseSet set = exerciseGroup.sets[index];

                          return TableRow(
                            children: List.generate(
                              set.data.length + 1,
                              (index2) {
                                index2 = index2 - 1;
                                if (index2 == -1) {
                                  return Text(
                                    set.type.name.substring(0, 1).capitalize,
                                    style: TextStyle(
                                      color: set.type.color(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                ExerciseSetData data = set.data[index2];
                                return Text(
                                  data.toShortString(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
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
