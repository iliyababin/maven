import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/session/screen/session_calendar_screen.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common/common.dart';
import '../../theme/theme.dart';
import '../../session/session.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      slivers: [
        BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return MultiSliver(
                children: const [
                  Heading(
                    title: 'History',
                    size: HeadingSize.small,
                  ),
                  SliverBoxWidget(
                    type: SliverBoxType.loading,
                  ),
                ],
              );
            } else if (state.status.isLoaded) {
              return MultiSliver(
                children: [
                  Heading(
                    title: 'History',
                    size: HeadingSize.small,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SessionCalendarScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showBottomSheetDialog(
                            context: context,
                            child: ListDialog(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.read<SessionBloc>().add(
                                          const SessionSetSort(
                                            sort: SessionSort.newest,
                                          ),
                                        );
                                  },
                                  leading: const Icon(
                                    Icons.tips_and_updates_outlined,
                                  ),
                                  title: const Text(
                                    'Newest',
                                  ),
                                  trailing: Icon(
                                    state.sort == SessionSort.newest
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.read<SessionBloc>().add(
                                          const SessionSetSort(
                                            sort: SessionSort.oldest,
                                          ),
                                        );
                                  },
                                  leading: const Icon(
                                    Icons.history_outlined,
                                  ),
                                  title: const Text(
                                    'Oldest',
                                  ),
                                  trailing: Icon(
                                    state.sort == SessionSort.oldest
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.read<SessionBloc>().add(
                                          const SessionSetSort(
                                            sort: SessionSort.volume,
                                          ),
                                        );
                                  },
                                  leading: const Icon(
                                    Icons.monitor_weight_outlined,
                                  ),
                                  title: const Text(
                                    'Volume',
                                  ),
                                  trailing: Icon(
                                    state.sort == SessionSort.volume
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.sort,
                        ),
                      ),
                    ],
                  ),
                  SessionListView(
                    sessions: state.sessions,
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'Something went wrong',
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
