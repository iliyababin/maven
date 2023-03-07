import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../theme/m_themes.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../../workout/model/workout.dart';

/// Widget that displays a paused workout
class PausedWorkoutWidget extends StatelessWidget {
  /// Creates a widget to display a paused workout
  const PausedWorkoutWidget({super.key,
    required this.workout,
  });

  /// Paused workout to display
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: mt(context).templateFolder.backgroundColor,
      child: InkWell(
        onTap: () {
          showBottomSheetDialog(
            context: context,
            child: ConfirmationDialog(
              title: 'Resume Workout',
              subtitle: 'Any active workouts will be discarded.',
              cancelText: 'Cancel',
              confirmText: 'Resume',
              onSubmit: () {
                context.read<WorkoutBloc>().add(WorkoutDelete());
                context.read<WorkoutBloc>().add(WorkoutUnpause(workout: workout));
              },
            ),
            onClose: (){}
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1,
                color: mt(context).borderColor
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      workout.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mt(context).text.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(minutes: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      'Created ${timeago.format(workout.timestamp)}',
                      style: TextStyle(
                        color: mt(context).text.secondaryColor
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}