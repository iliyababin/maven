import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../common/common.dart';
import '../../exercise/bloc/bloc.dart';
import '../template.dart';

class TemplateListView extends StatelessWidget {
  const TemplateListView({Key? key}) : super(key: key);

  final SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 1,
  );

  @override
  Widget build(BuildContext context) {
    final templateState = context.watch<TemplateBloc>().state;
    final exerciseState = context.watch<ExerciseBloc>().state;

    if (templateState.status.isLoading || exerciseState.status.isLoading) {
      return const SliverBoxWidget(
        type: SliverBoxType.loading,
      );
    } else if (templateState.templates.isEmpty) {
      return const SliverBoxWidget(
        type: SliverBoxType.empty,
      );
    } else {
      return SliverReorderableGrid(
        itemCount: templateState.templates.length,
        gridDelegate: gridDelegate,
        proxyDecorator: (child, index, animation) =>
            ProxyDecorator(child, index, animation, context),
        itemBuilder: (context, index) {
          return ReorderableGridDelayedDragStartListener(
            key: ValueKey(templateState.templates[index].routine.id),
            index: index,
            child: TemplateWidget(
              template: templateState.templates[index],
              exercises: exerciseState.exercises,
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          context.read<TemplateBloc>().add(
                TemplateReorder(oldIndex: oldIndex, newIndex: newIndex),
              );
        },
      );
    }
  }
}
