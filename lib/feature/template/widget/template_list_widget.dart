import 'package:Maven/feature/template/widget/empty_widget.dart';
import 'package:Maven/feature/template/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/reorder_sliver_list.dart';
import '../../../theme/m_themes.dart';
import '../bloc/template/template_bloc.dart';
import '../model/template.dart';
import 'template_card_widget.dart';

class TemplateListWidget extends StatefulWidget {
  const TemplateListWidget({Key? key}) : super(key: key);

  @override
  State<TemplateListWidget> createState() => _TemplateListWidgetState();
}

class _TemplateListWidgetState extends State<TemplateListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const LoadingWidget();
        } else if (state.status.isLoaded) {
          List<Template> templates = state.templates;

          return templates.isEmpty ? const EmptyWidget() :
          ReorderSliverList(
            children: templates,
            itemBuilder: (context, index) {
              Template template = templates[index];
              return Padding(
                padding: EdgeInsetsDirectional.only(bottom: index == templates.length-1 ? 0 : 12),
                child: TemplateCard(
                  template: template,
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                Template template = templates.removeAt(oldIndex);
                templates.insert(newIndex, template);
                context.read<TemplateBloc>().add(TemplateReorder(templates: templates));
              });
            },
          );
        } else {
          return SliverToBoxAdapter(
            child: Text(
              'There was an error fetching the templates.',
              style: mt(context).textStyle.body1,
            ),
          );
        }
      },
    );
  }
}
