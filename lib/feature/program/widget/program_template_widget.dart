import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../program.dart';

class ProgramTemplateWidget extends StatelessWidget {
  const ProgramTemplateWidget({
    super.key,
    required this.programTemplate,
    this.extended = false,
    required this.onTap,
    required this.onEdit,
  });

  final ProgramTemplate programTemplate;
  final bool extended;
  final VoidCallback onTap;
  final Function(ProgramTemplate programTemplate) onEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(T(context).space.large),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: T(context).color.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  programTemplate.name,
                  style: T(context).textStyle.titleLarge,
                ),
                extended ? Text(
                  programTemplate.note,
                  style: T(context).textStyle.bodyMedium,
                ) : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DaySelectorScreen(
                          day: programTemplate.day,
                        ),
                      ),
                    ).then((value) {
                      if (value != null) {
                        onEdit(programTemplate.copyWith(day: value));
                      }
                    });
                  },
                  child: Text(
                    programTemplate.day.name.capitalize,
                    style: T(context).textStyle.bodyMedium.copyWith(
                      color: T(context).color.primary,
                    ),
                  ),
                ),
                extended ? Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.today,
                              size: 18,
                              color: T(context).color.onSurfaceVariant,
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              programTemplate.day.name.capitalize,
                              style: T(context).textStyle.bodyMedium.copyWith(
                                color: T(context).color.onSurfaceVariant,
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
                              programTemplate.complete ? 'Complete' : programTemplate.timestamp.timeLeft(),
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
                  ],
                ) : const SizedBox(height: 2,),
                extended ? Text(
                  'Exercise',
                  style: T(context).textStyle.titleSmall,
                ) : const SizedBox(height: 2,),
                extended ? ListView.builder(
                  itemCount: programTemplate.exerciseBundles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final exerciseBundle = programTemplate.exerciseBundles[index];
                    return Text(
                      '\u2022 ${exerciseBundle.exercise.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: T(context).textStyle.bodyMedium,
                    );
                  },
                ) : Expanded(
                  child: ListView.builder(
                    itemCount: programTemplate.exerciseBundles.length,
                    itemBuilder: (context, index) {
                      final exerciseBundle = programTemplate.exerciseBundles[index];
                      return Text(
                        '\u2022 ${exerciseBundle.exercise.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: T(context).textStyle.bodyMedium,
                      );
                    },
                  ),
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
