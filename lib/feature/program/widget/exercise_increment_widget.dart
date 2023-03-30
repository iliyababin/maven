import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../model/exercise_increment.dart';

class ExerciseIncrementWidget extends StatelessWidget {
  const ExerciseIncrementWidget({super.key,
    required this.exerciseIncrement,
    required this.onExerciseIncrementChanged,
  });

  final ExerciseIncrement exerciseIncrement;
  final ValueChanged<ExerciseIncrement> onExerciseIncrementChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){},
      child: Container(
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15),
          border: Border.all(
            width: 1,
            color: mt(context).borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exerciseIncrement.exercise.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: mt(context).text.primaryColor
              ),
            )
          ],
        ),
      ),
    );
  }
}