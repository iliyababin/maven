
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../program.dart';

class ProgramListView extends StatefulWidget {
  const ProgramListView({Key? key}) : super(key: key);

  @override
  State<ProgramListView> createState() => _ProgramListViewState();
}

class _ProgramListViewState extends State<ProgramListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const LoadingWidget();
        } else if (state.status.isLoaded) {
          List<Program> programs = state.programs;

          if(programs.isEmpty) {
            return SliverBoxWidget();
          }

          return SliverReorderableGrid(
            itemCount: programs.length,
            proxyDecorator: (child, index, animation) => ProxyDecorator(child, index, animation, context),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),

            itemBuilder: (context, index) {
              Program program = programs[index];
              return ReorderableGridDelayedDragStartListener(
                key: ValueKey(program.id),
                index: index,
                child: ProgramWidget(
                  program: program,
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Program item = programs.removeAt(oldIndex);
                programs.insert(newIndex, item);
              });
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
