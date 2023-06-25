import 'package:flutter/material.dart';
import 'package:maven/common/extension.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/model/exercise_bundle.dart';

class ProgramTemplateWidget extends StatelessWidget {
  const ProgramTemplateWidget({
    super.key,
    required this.programTemplate,
  });

  final ProgramTemplate programTemplate;

  @override
  Widget build(BuildContext context) {
    DateTime due = DateTime(
      programTemplate.timestamp.year,
      programTemplate.timestamp.month,
      programTemplate.timestamp.day,
    );
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    Duration difference = due.difference(now);
    String timeRemaining;

    if (difference.isNegative) {
      timeRemaining = 'Past Due';
    } else if (difference.inDays > 0) {
      timeRemaining = 'Complete in ${difference.inDays} days';
    } else {
      timeRemaining = 'Complete Today';
    }

    return Stack(
      children: [
        InkWell(
          onTap: (){},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: T(context).color.outline,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  programTemplate.name,
                  style: T(context).textStyle.titleLarge,
                ),
                Text(
                  programTemplate.description,
                  style: T(context).textStyle.bodyMedium,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.today,
                          size: 18,
                          color: T(context).color.subtext,
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          programTemplate.day.name.capitalize(),
                          style: T(context).textStyle.bodyMedium.copyWith(
                            color: T(context).color.subtext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 18,
                          color: programTemplate.complete ? T(context).color.success : T(context).color.error,
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          programTemplate.complete ? 'Complete' : timeRemaining,
                          style: T(context).textStyle.bodyMedium.copyWith(
                            color: programTemplate.complete ? T(context).color.success : T(context).color.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exercise',
                            style: T(context).textStyle.titleSmall,
                          ),
                          programTemplate.exerciseBundles.isNotEmpty ? ListView.builder(
                            itemCount: programTemplate.exerciseBundles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ExerciseBundle exerciseBundle = programTemplate.exerciseBundles[index];
                              return Text(
                                '\u2022 ${exerciseBundle.exercise.name}',
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
                  ],
                )

              ],
            ),
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
      ],
    );
  }
}
