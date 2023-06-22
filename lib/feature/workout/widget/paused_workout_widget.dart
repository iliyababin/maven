import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../database/model/workout.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../bloc/workout/workout_bloc.dart';

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
      color: T(context).color.background,
      child: InkWell(
        onTap: () {
          showBottomSheetDialog(
            context: context,
            child: ConfirmationDialog(
              title: 'Resume Workout',
              subtitle: 'Current workout will be deleted',
              cancelText: 'Cancel',
              confirmText: 'Resume',
              onSubmit: () {
                context.read<WorkoutBloc>().add(WorkoutToggle(workout: workout.copyWith(active: true)));
                /*context.read<WorkoutBloc>().add(WorkoutDelete());
                context.read<WorkoutBloc>().add(WorkoutUpdate(workout: workout.copyWith(isPaused: 0)));*/
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
              color: T(context).color.secondary,
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
                      style: T(context).textStyle.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(minutes: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      'Created ${timeago.format(workout.timestamp)}',
                      style: T(context).textStyle.subtitle1,
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