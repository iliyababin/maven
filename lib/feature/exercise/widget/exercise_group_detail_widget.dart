import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

class ExerciseGroupDetailWidget extends StatelessWidget {
  const ExerciseGroupDetailWidget({
    Key? key,
    this.routine,
    required this.exercise,
    required this.exerciseGroup,
  }) : super(key: key);

  final Routine? routine;
  final Exercise exercise;
  final ExerciseGroupDto exerciseGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(T(context).space.large),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(T(context).shape.large),
        color: T(context).color.surface,
      ),
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if(state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(routine != null)
                  Text(
                    routine!.name,
                    style: T(context).textStyle.titleLarge,
                  ),
                Text(
                  routine == null ? exercise.name : DateFormat.yMMMMEEEEd().format(routine!.timestamp),
                  style: routine == null ? T(context).textStyle.titleMedium : T(context).textStyle.labelMedium,
                ),
                SizedBox(
                  height: 2,
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
                              ExerciseSetDataDto data = exerciseGroup.sets.first.data[index];
                              return Text(
                                data.fieldType.generateTitle(exerciseGroup),
                                style: T(context).textStyle.titleSmall,
                              );
                            },
                          ),
                        );
                      }
                      ExerciseSetDto set = exerciseGroup.sets[index];

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
                            ExerciseSetDataDto data = set.data[index2];
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
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
