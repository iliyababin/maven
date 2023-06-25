import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../database/database.dart';
import '../../../theme/widget/inherited_theme_widget.dart';

class CompleteExerciseWidget extends StatelessWidget {
  const CompleteExerciseWidget({Key? key,
    required this.complete,
    required this.completeExerciseSets,
  }) : super(key: key);

  final Session complete;
  final List<SessionExerciseSet> completeExerciseSets;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: T(context).color.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          /*Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteDetailScreen(
            completeBundle: complete,
          )));*/
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
                complete.name,
                style: T(context).textStyle.titleLarge,
              ),
              const SizedBox(height: 4,),
              Text(
                DateFormat.yMMMMEEEEd().format(complete.timestamp).toString(),
                style: T(context).textStyle.subtitle2,
              ),
              const SizedBox(height: 12,),
              Text(
                'Sets Performed',
                style: T(context).textStyle.bodyLarge,
              ),
              const SizedBox(height: 4,),
              ListView.separated(
                itemCount: completeExerciseSets.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 1,);
                },
                itemBuilder: (context, index) {
                  final SessionExerciseSet completeExerciseSet = completeExerciseSets[index];

                  final Color? color = completeExerciseSet.type == ExerciseSetType.regular ? null : completeExerciseSet.type.color(context);
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          completeExerciseSet.type == ExerciseSetType.regular ? (index+1).toString() : completeExerciseSet.type.name.substring(0, 1),
                          style: T(context).textStyle.bodyMedium.copyWith(color: color),
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Text(
                          '//TODO',
                          style: T(context).textStyle.bodyMedium.copyWith(color: color),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
