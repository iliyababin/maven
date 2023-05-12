import 'package:Maven/common/widget/heading.dart';
import 'package:Maven/common/widget/titled_scaffold.dart';
import 'package:Maven/feature/template/widget/empty_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/model/complete.dart';
import '../../complete/bloc/complete_bloc/complete_bloc.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page),
        child: CustomScrollView(
          slivers: [
            Heading(title: 'History', topPadding: false,),
            BlocBuilder<CompleteBloc, CompleteState>(
              builder: (context, state) {
                if(state.status.isLoading) {
                  return SliverToBoxAdapter(child: Container(),);
                } else if(state.status.isLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.completes.length,
                      (context, index) {
                        Complete complete  = state.completes[index];
                        return Text(complete.name);
                      },
                    ),
                  );
                } else {
                  return const EmptyWidget();
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
