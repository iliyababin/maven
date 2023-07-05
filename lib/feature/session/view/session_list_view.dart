import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../session.dart';

class SessionListView extends StatelessWidget {
  const SessionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (context, index) => LoadingSkeleton(
                offset: index,
                child: Container(
                  height: 125,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: T(context).color.background,
                  ),
                ),
              ),
            ),
          );
        } else if (state.status.isLoaded) {
          if (state.sessions.isEmpty) {
            return const EmptyWidget();
          }

          return SliverList.separated(
            itemCount: state.sessions.length,
            separatorBuilder: (context, index) => SizedBox(
              height: T(context).space.medium,
            ),
            itemBuilder: (context, index) {
              Session session = state.sessions[index];
              return SessionWidget(session: session);
            },
          );
        } else {
          return const EmptyWidget();
        }
      },
    );
  }
}
