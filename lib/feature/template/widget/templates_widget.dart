import 'package:Maven/feature/template/widget/template_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart' as R;

import '../model/template.dart';

class TemplateSliverListWidget extends StatefulWidget {
  const TemplateSliverListWidget({Key? key,
    required this.templates,
  }) : super(key: key);

  final List<Template> templates;

  @override
  State<TemplateSliverListWidget> createState() => _TemplateSliverListWidgetState();
}

class _TemplateSliverListWidgetState extends State<TemplateSliverListWidget> {
  late List<Template> templates;

  @override
  void initState() {
    templates = List.from(widget.templates);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return R.ReorderableSliverList(
      buildDraggableFeedback: (context, constraints, child) {
        return Container(
          constraints: constraints,
          child: child,
        );
      },
      delegate: R.ReorderableSliverChildBuilderDelegate(
        childCount: templates.length,
            (BuildContext context, int index) {
          Template template = templates[index];

          return Container(
              margin: const EdgeInsetsDirectional.only(bottom: 16,),
              child: TemplateCard(
                template: template,
              )
          );
        },
      ),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          Template template = templates.removeAt(oldIndex);
          templates.insert(newIndex, template);
        });
        /*context.read<TemplateBloc>().add(TemplateReorder(templates: templates));*/
      },
    );
  }
}
