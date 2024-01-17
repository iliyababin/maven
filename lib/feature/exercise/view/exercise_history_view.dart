import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/exercise/widget/exercise_group_detail_widget.dart';

import '../../../database/database.dart';
import '../../session/session.dart';
import '../../theme/theme.dart';
import '../exercise.dart';


class ExerciseHistoryView extends StatefulWidget {
  const ExerciseHistoryView({Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  State<ExerciseHistoryView> createState() => _ExerciseHistoryViewState();
}

class _ExerciseHistoryViewState extends State<ExerciseHistoryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          List<Session> sessions = state.sessions.where((session) {
            List<ExerciseGroupDto> groups = session.exerciseGroups
                .where((group) => group.exerciseId == widget.exercise.id)
                .toList();
            if (groups.isNotEmpty) {
              return true;
            } else {
              return false;
            }
          }).toList();

          if(sessions.isEmpty) {
            return const Center(
              child: Text('No history'),
            );
          }

          return Padding(
            padding: EdgeInsets.all(T(context).space.large),
            child: ListView.separated(
              itemCount: sessions.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return ExerciseGroupDetailWidget(
                  routine: sessions[index].routine,
                  exercise: widget.exercise,
                  exerciseGroup: sessions[index]
                      .exerciseGroups
                      .firstWhere((element) => element.exerciseId == widget.exercise.id),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
