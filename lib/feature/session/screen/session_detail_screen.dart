import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../session.dart';

class SessionDetailScreen extends StatefulWidget {
  const SessionDetailScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  final Session session;

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session',
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: 'About',
            ),
            Tab(
              text: 'Exercise',
            ),
          ],
        ),
      ),
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if(state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            Session session = state.sessions.firstWhere((element) => element.routine.id == widget.session.routine.id);

            return TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(T(context).space.large),
                  child: SessionAboutView(
                    session: session,
                  ),
                ),
                Text('nnie'),
              ],
            );

            return BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if (state.status.isLoaded) {
                  return ListView.separated(
                    itemCount: session.exerciseGroups.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) {
                      ExerciseGroup exerciseGroup = session.exerciseGroups[index];
                      Exercise exercise = state.exercises.firstWhere((element) => element.id == exerciseGroup.exerciseId);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          ListView.builder(
                            itemCount: exerciseGroup.sets.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ExerciseSet exerciseSet = exerciseGroup.sets[index];

                              return Text(
                                exerciseSet.data.map((data) => data.stringify(exerciseGroup).toString()).toList().toString(),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }

        },
      ),
    );
  }
}
