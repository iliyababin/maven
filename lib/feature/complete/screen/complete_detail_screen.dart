import 'package:flutter/material.dart';

import '../../../database/model/model.dart';
import '../model/complete_bundle.dart';
import '../model/complete_exercise_bundle.dart';

class CompleteDetailScreen extends StatelessWidget {
  const CompleteDetailScreen({Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final CompleteBundle completeBundle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          completeBundle.complete.name,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: mt(context).padding.page,
          right: mt(context).padding.page,
          top: mt(context).padding.page,
        ),
        child: ListView.separated(
          itemCount: completeBundle.completeExerciseBundles.length,
          separatorBuilder: (context, index) => SizedBox(height: 12,),
          itemBuilder: (context, index) {
            CompleteExerciseBundle completeExerciseBundle = completeBundle.completeExerciseBundles[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  completeExerciseBundle.exercise.name,
                  style: mt(context).textStyle.body1,
                ),
                SizedBox(height: 2,),
                ListView.builder(
                  itemCount: completeExerciseBundle.completeExerciseSets.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CompleteExerciseSet completeExerciseSet = completeExerciseBundle.completeExerciseSets[index];
                    return RichText(
                      text: TextSpan(
                        style: mt(context).textStyle.subtitle1,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${index + 1}',
                            style: mt(context).textStyle.body1.copyWith(color: completeExerciseSet.setType.color(context)),
                          ),
                          const TextSpan(
                            text: '  ',
                          ),
                          TextSpan(
                            text: '${completeExerciseSet.option1} x ${completeExerciseSet.option2}',
                          ),
                        ],
                      ),

                    );
                    return Text(
                      ' ${completeExerciseSet.option1} x ${completeExerciseSet.option2}',
                      style: mt(context).textStyle.body1,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
