import 'package:Maven/common/model/workout.dart';
import 'package:Maven/feature/workout/screen/view_workout_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({Key? key,
    required this.workout,
  }) : super(key: key);

  final double borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: mt(context).workoutCard.backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: () => _showWorkout(context, workout),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1,
              color: mt(context).borderColor
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout.name,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: mt(context).text.primaryColor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1,),
                  Text(
                    'Chest, Triceps, Shoulders',
                    style: TextStyle(
                        fontSize: 15,
                        color: mt(context).text.accentColor
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Description: Doing stuff',
                    style: TextStyle(
                        fontSize: 13,
                        color: mt(context).text.secondaryColor
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
  
  ///
  /// Functions
  /// 
  
  void _showWorkout(BuildContext context, Workout workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
          ViewWorkoutScreen(
            workout: workout
          )
      )
    );
  }
}
