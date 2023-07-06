import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../session.dart';


class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  final Session session;

  /* List<TextSpan> test(Session seb, int index, BuildContext context) {
    List<TextSpan> result = [];

    result.add(TextSpan(
      text: '${index + 1}  ',
      style: T(context).textStyle.bodyMedium.copyWith(
            color: seb.sessionExerciseSets[index].type.color(context),
          ),
    ));

    for (int i = 0; i < seb.sessionExerciseSets[index].data.length; i++) {
      result.add(TextSpan(
        text: seb.sessionExerciseSets[index].data[i].stringify(seb.sessionExerciseGroup),
        style: TextStyle(
          color: T(context).color.onBackground,
        ),
      ));

      if (i < seb.sessionExerciseSets[index].data.length - 1) {
        result.add(TextSpan(
          text: ' x ',
          style: TextStyle(
            color: T(context).color.onBackground,
          ),
        ));
      }
    }
    return result;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: T(context).space.large,
          right: T(context).space.large,
          top: T(context).space.large,
        ),
        child: BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (context, state) {
            if(state.status.isLoaded) {
              return ListView.separated(
                itemCount: session.exerciseGroups.length,
                separatorBuilder: (context, index) =>
                const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  ExerciseGroup exerciseGroup = session.exerciseGroups[index];
                  Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      ListView.builder(
                        itemCount: exerciseGroup.sets.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ExerciseSet exerciseSet = exerciseGroup.sets[index];

                          return Text(
                            exerciseSet.data.map((data) => data.stringify(exerciseGroup).toString()).toList().toString(),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
