import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../common/common.dart';
import '../template.dart';

class TemplateListView extends StatelessWidget {
  const TemplateListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return const SliverBoxWidget(
            type: SliverBoxType.loading,
          );
        } else if (state.status.isLoaded) {
          List<Template> templates = state.templates;

          if(templates.isEmpty) {
            return const SliverBoxWidget();
          }

          return SliverReorderableGrid(
            itemCount: templates.length,
            proxyDecorator: (child, index, animation) => ProxyDecorator(child, index, animation, context),
            itemBuilder: (context, index) {
              return ReorderableGridDelayedDragStartListener(
                key: ValueKey(templates[index].id),
                index: index,
                child: TemplateWidget(
                  template: templates[index],
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              context.read<TemplateBloc>().add(
                TemplateReorder(oldIndex: oldIndex, newIndex: newIndex),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
          );
        } else {
          throw Exception('Unhandled state: $state');
        }
      },
    );
  }
}
