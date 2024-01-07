import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../session.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({
    Key? key,
    required this.session,
    this.dateEnabled = true,
  }) : super(key: key);

  final Session session;
  final bool dateEnabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(T(context).shape.large),
      child: Material(
        color: T(context).color.surface,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionDetailScreen(
                  session: session,
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.routine.name,
                  style: T(context).textStyle.titleLarge,
                ),
                if(dateEnabled)
                Text(
                  DateFormat.yMMMMEEEEd().format(session.routine.timestamp).toString(),
                  style: T(context).textStyle.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: T(context).color.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      session.data.timeElapsed.toString(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.monitor_weight,
                      color: T(context).color.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      s(context).parseWeight(session.volume).truncateZeros,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    return session.exerciseGroups.isNotEmpty
                        ? ListView.builder(
                            itemCount: session.exerciseGroups.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ExerciseGroupDto exerciseGroup = session.exerciseGroups[index];

                              if (state.status.isLoading) {
                                return Shimmer.fromColors(
                                  baseColor: T(context).color.surface.baseShimmer,
                                  highlightColor: T(context).color.surface.highlightShimmer,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: T(context).color.surface,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
                                return Text(
                                  '${exerciseGroup.sets.length} x ${exercise.name}',
                                );
                              }
                            },
                          )
                        : const Text(
                            'None',
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
