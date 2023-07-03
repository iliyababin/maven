/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../session.dart';


class SessionWidget extends StatelessWidget {
  const SessionWidget({Key? key,
    required this.sessionBundle,
  }) : super(key: key);

  final SessionBundle sessionBundle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        */
/*Navigator.push(context, MaterialPageRoute(builder: (context) => SessionDetailScreen(
          completeBundle: sessionBundle,
        )));*//*

      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: T(context).color.outline,
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sessionBundle.session.name,
              style: T(context).textStyle.titleLarge,
            ),
            const SizedBox(height: 5,),
            Text(
              DateFormat.yMMMMEEEEd().format(sessionBundle.session.timestamp).toString(),
              style: T(context).textStyle.labelSmall,
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: T(context).color.onSurfaceVariant,
                ),
                const SizedBox(width: 5,),
                Text(
                  durationToTime(sessionBundle.session.duration),
                  style: T(context).textStyle.bodyLarge,
                ),
                const SizedBox(width: 20,),
                Icon(
                  Icons.monitor_weight,
                  color: T(context).color.onSurfaceVariant,
                ),
                const SizedBox(width: 5,),
                Text(
                  sessionBundle.volume.toString(),
                  style: T(context).textStyle.bodyLarge,
                ),
                const SizedBox(width: 20,),

              ],
            ),
            const SizedBox(height: 12,),
            sessionBundle.sessionExerciseBundles.isNotEmpty ? ListView.builder(
              itemCount: sessionBundle.sessionExerciseBundles.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                SessionExerciseBundle sessionExerciseBundle = sessionBundle.sessionExerciseBundles[index];
                return Text(
                  '${sessionExerciseBundle.sessionExerciseSets.length} x ${sessionExerciseBundle.exercise.name}',
                  style: T(context).textStyle.bodyMedium,
                );
              },
            ) : Text(
              'None',
              style: T(context).textStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
*/
