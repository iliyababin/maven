import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/session/widget/session_weekly_goal_widget.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../session/session.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Home',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Dashboard',
              size: HeadingSize.small,
            ),
            BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if(state.status.isLoading) {
                  return const SliverBoxWidget(
                    type: SliverBoxType.loading,
                  );
                } else if (state.status.isLoaded) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SessionWeeklyGoalWidget(
                        goal: s(context).sessionWeeklyGoal,
                        onModified: (value) {
                          InheritedSettingWidget.of(context).setSessionWeeklyGoal(value);
                        },
                        dates: state.sessions.map((e) => e.routine.timestamp).toList(),
                      ),
                      SizedBox(
                        height: T(context).space.medium,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(
                                T(context).space.large,
                              ),
                              decoration: BoxDecoration(
                                color: T(context).color.surface,
                                borderRadius: BorderRadius.circular(
                                  T(context).shape.large,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.local_fire_department_rounded,
                                    color: Colors.orange,
                                    size: 44,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DatabaseService.getWeekStreak(state.sessions.map((e) => e.routine.timestamp).toList()).toString(),
                                        style: T(context).textStyle.headingMedium,
                                      ),
                                      const Text(
                                        'Week Streak',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: T(context).space.medium,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(
                                T(context).space.large,
                              ),
                              decoration: BoxDecoration(
                                color: T(context).color.surface,
                                borderRadius: BorderRadius.circular(
                                  T(context).shape.large,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Total Workouts',
                                  ),
                                  Text(
                                    '${state.sessions.length}',
                                    style: T(context).textStyle.headingMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                } else {
                  return const SliverBoxWidget(
                    type: SliverBoxType.empty,
                  );
                }
              },
            ),
            const Heading(
              title: 'Exercises',
            ),
            SliverList(
              delegate: SliverChildListDelegate([]),
            ),
          ],
        ),
      ),
    );
  }
}
