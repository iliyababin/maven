import 'package:flutter/material.dart';

import '../../../database/model/template.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../screen/template_detail_screen.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({
    Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  final double _borderRadius = 16;
  late bool? _completed;

  @override
  void initState() {
    _completed = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TemplateDetailScreen(
              template: widget.template,
            ),
          ),
        );
      },

      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: T(context).color.surface,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.template.name,
                  style: T(context).textStyle.titleLarge,
                  maxLines: 1,
                ),
                Text(
                  widget.template.description,
                  style: T(context).textStyle.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
