import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maven/common/common.dart';
import 'package:maven/feature/session/bloc/session_bloc/session_bloc.dart';

import '../../../database/database.dart';
import '../../session/session.dart';
import '../../theme/theme.dart';

class TransferDetailScreen extends StatelessWidget {
  const TransferDetailScreen({
    super.key,
    required this.import,
  });

  final Import import;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Details',
          ),
          actions: [
            IconButton(
              onPressed: () {
                showBottomSheetDialog(
                  context: context,
                  child: Column(
                    children: [
                      ListDialog(
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.delete,
                              color: T(context).color.error,
                            ),
                            title: Text(
                              'Delete Import',
                              style: TextStyle(
                                color: T(context).color.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isLoaded) {
              final List<Session> sessions = state.sessions
                  .where((element) => element.data.importId == import.id)
                  .toList();

              return CustomScrollView(
                slivers: [
                  const Heading(
                    title: 'Workouts',
                    side: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: sessions.length,
                      (context, index) {
                        final Session session = sessions[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: T(context).space.large,
                            right: T(context).space.large,
                            bottom: T(context).space.medium,
                          ),
                          child: SessionWidget(session: session),
                        );
                      },
                    ),
                  )
                ],
              );
              return ListView.separated(
                itemCount: sessions.length,
                padding: EdgeInsets.all(
                  T(context).space.large,
                ),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: T(context).space.medium,
                  );
                },
                itemBuilder: (context, index) {
                  final Session session = sessions[index];
                  return SessionWidget(session: session);
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Something went wrong',
                ),
              );
            }
          },
        ));
  }
}
