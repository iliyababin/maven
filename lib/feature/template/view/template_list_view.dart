import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
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
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return SliverGrid(
            gridDelegate: gridDelegate,
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) {
                return Shimmer.fromColors(
                  baseColor: T(context).color.surface.baseShimmer,
                  highlightColor: T(context).color.surface.highlightShimmer,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: T(context).color.surface,
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state.status.isLoaded) {
          List<Template> templates = state.templates;

          if(templates.isEmpty) {
            return const SliverBoxWidget();
          }

          return SliverReorderableGrid(
            itemCount: templates.length,
            gridDelegate: gridDelegate,
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
          );
        } else {
          throw Exception('Unhandled state: $state');
        }
      },
    );
  }
}
