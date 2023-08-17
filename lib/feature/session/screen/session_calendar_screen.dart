import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../theme/theme.dart';
import '../session.dart';

class SessionCalendarScreen extends StatefulWidget {
  const SessionCalendarScreen({Key? key}) : super(key: key);

  @override
  State<SessionCalendarScreen> createState() => _SessionCalendarScreenState();
}

class _SessionCalendarScreenState extends State<SessionCalendarScreen> {
  late DateTime _selectedDay;

  @override
  initState() {
    _selectedDay = DateUtils.dateOnly(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
        ),
      ),
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            List<DateTime> dates = state.sessions
                .map((e) => DateUtils.dateOnly(e.routine.timestamp))
                .toList();
            List<Session> selectedSessions = state.sessions
                .where((element) =>
                    DateUtils.dateOnly(element.routine.timestamp) ==
                    DateUtils.dateOnly(_selectedDay))
                .toList();
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: T(context).space.large,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: T(context).space.large,
                  ),
                  sliver: MultiSliver(
                    children: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: T(context).space.medium,
                            right: T(context).space.medium,
                            bottom: T(context).space.medium,
                          ),
                          decoration: BoxDecoration(
                            color: T(context).color.surface,
                            borderRadius: BorderRadius.circular(
                              T(context).space.large,
                            ),
                          ),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _selectedDay,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            eventLoader: (day) {
                              if (dates.contains(DateUtils.dateOnly(day))) {
                                return [day];
                              } else {
                                return [];
                              }
                            },
                            rowHeight: 50,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: T(context).color.primary,
                                shape: BoxShape.circle,
                              ),
                              markerDecoration: BoxDecoration(
                                color: T(context).color.secondary,
                                shape: BoxShape.circle,
                              ),
                              weekendTextStyle: TextStyle(
                                color: T(context).color.onSurface,
                              ),
                              todayDecoration: BoxDecoration(
                                color: T(context).color.inverseSurface,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                              });
                            },
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                            ),
                          ),
                        ),
                      ),
                      const Heading(title: 'Sessions'),
                      selectedSessions.isNotEmpty
                          ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: selectedSessions.length,
                              (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: T(context).space.medium,
                              ),
                              child: SessionWidget(
                                dateEnabled: false,
                                session: selectedSessions[index],
                              ),
                            );
                          },
                        ),
                      )
                          : const SliverBoxWidget(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Error',
              ),
            );
          }
        },
      ),
    );
  }
}
