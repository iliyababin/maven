import 'package:flutter/material.dart';

import '../../../database/model/model.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../model/complete_bundle.dart';
import '../model/complete_exercise_bundle.dart';

class CompleteDetailScreen extends StatelessWidget {
  const CompleteDetailScreen({Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final SessionBundle completeBundle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          completeBundle.session.name,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: T(context).padding.page,
          right: T(context).padding.page,
          top: T(context).padding.page,
        ),
        child: ListView.separated(
          itemCount: completeBundle.sessionExerciseBundles.length,
          separatorBuilder: (context, index) => SizedBox(height: 12,),
          itemBuilder: (context, index) {
            SessionExerciseBundle completeExerciseBundle = completeBundle.sessionExerciseBundles[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  completeExerciseBundle.exercise.name,
                  style: T(context).textStyle.body1,
                ),
                SizedBox(height: 2,),
                ListView.builder(
                  itemCount: completeExerciseBundle.sessionExerciseSets.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    SessionExerciseSet completeExerciseSet = completeExerciseBundle.sessionExerciseSets[index];
                    return RichText(
                      text: TextSpan(
                        style: T(context).textStyle.subtitle1,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${index + 1}',
                            style: T(context).textStyle.body1.copyWith(color: completeExerciseSet.type.color(context)),
                          ),
                          const TextSpan(
                            text: '  ',
                          ),
                          TextSpan(
                            text: '//TODO',
                          ),
                        ],
                      ),

                    );
                    /*return Text(
                      ' ${completeExerciseSet.option1} x ${completeExerciseSet.option2}',
                      style: T(context).textStyle.body1,
                    );*/
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
