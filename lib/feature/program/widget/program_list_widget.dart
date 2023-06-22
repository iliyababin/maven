import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/program/widget/program_widget.dart';
import 'package:maven/feature/template/widget/empty_widget.dart';
import 'package:maven/feature/template/widget/loading_widget.dart';

import '../../../common/widget/reorder_sliver_list.dart';
import '../../../database/TEST_ZONE/program.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../bloc/program/program_bloc.dart';

class ProgramListWidget extends StatefulWidget {
  const ProgramListWidget({Key? key}) : super(key: key);

  @override
  State<ProgramListWidget> createState() => _ProgramListWidgetState();
}

class _ProgramListWidgetState extends State<ProgramListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const LoadingWidget();
        } else if (state.status.isLoaded) {
          List<Program> programs = state.programs;

          return programs.isEmpty ? const EmptyWidget() : ReorderSliverList(
            children: programs,
            itemBuilder: (context, index) {
              Program program = programs[index];
              return ProgramWidget(
                program: program,
              );
            },
            onReorder: (oldIndex, newIndex) {

            },
          );
        } else {
          return SliverToBoxAdapter(
            child: Text(
              'There was an error fetching the programs.',
              style: T(context).textStyle.bodyLarge,
            ),
          );
        }
      },
    );
  }
}
