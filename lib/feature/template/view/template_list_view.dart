import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/widget/loading_widget.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../common/widget/proxy_decorator.dart';
import '../../../database/database.dart';
import '../template.dart';

class TemplateListView extends StatelessWidget {
  const TemplateListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return LoadingWidget();
        } else if (state.status.isLoaded) {
          List<Template> templates = state.templates;

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

            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Container(
              height: 80,
              child: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
