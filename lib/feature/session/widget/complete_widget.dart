import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/util/general_utils.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../model/complete_bundle.dart';
import '../model/complete_exercise_bundle.dart';
import '../screen/complete_detail_screen.dart';

class CompleteWidget extends StatelessWidget {
  const CompleteWidget({Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final SessionBundle completeBundle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: T(context).color.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SessionDetailScreen(
            completeBundle: completeBundle,
          )));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: T(context).color.secondary,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                completeBundle.session.name,
                style: T(context).textStyle.heading3,
              ),
              SizedBox(height: 5,),
              Text(
                DateFormat.yMMMMEEEEd().format(completeBundle.session.timestamp).toString(),
                style: T(context).textStyle.subtitle2,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: T(context).color.subtext,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    durationToTime(completeBundle.session.duration),
                    style: T(context).textStyle.body1,
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.monitor_weight,
                    color: T(context).color.subtext,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    completeBundle.volume.toString(),
                    style: T(context).textStyle.body1,
                  ),
                  SizedBox(width: 20,),

                ],
              ),
              SizedBox(height: 12,),
              completeBundle.sessionExerciseBundles.isNotEmpty ? ListView.builder(
                itemCount: completeBundle.sessionExerciseBundles.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  SessionExerciseBundle completeExerciseBundle = completeBundle.sessionExerciseBundles[index];
                  return Text(
                    '${completeExerciseBundle.sessionExerciseSets.length} x ${completeExerciseBundle.exercise.name}',
                    style: T(context).textStyle.subtitle1,
                  );
                },
              ) : Text(
                'None',
                style: T(context).textStyle.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
