import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/LoadingSkeleton.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../template/widget/empty_widget.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../model/complete_bundle.dart';
import 'session_widget.dart';

class CompleteListWidget extends StatelessWidget {
  const CompleteListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (context, index) => Padding(
                padding: EdgeInsetsDirectional.only(bottom: index == state.completeBundles.length - 1 ? 0 : 12),
                child: LoadingSkeleton(
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
              )
            ),
          );
        } else if(state.status.isLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.completeBundles.length,
                (context, index) {
                SessionBundle completeBundle  = state.completeBundles[index];
                return Padding(
                  padding: EdgeInsetsDirectional.only(bottom: index == state.completeBundles.length - 1 ? 0 : 12),
                  child: SessionWidget(
                    sessionBundle: completeBundle,
                  ),
                );
              },
            ),
          );
        } else {
          return const EmptyWidget();
        }
      },
    );
  }
}