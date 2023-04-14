import 'package:flutter/material.dart';

import '../../../theme/m_themes.dart';
import '../model/template.dart';
import '../screen/view_template_screen.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  final double _borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: mt(context).color.background,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTemplateScreen(
            template: template,
          )));
        },
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: Border.all(
                color: mt(context).color.secondary,
              )
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                template.name,
                style: mt(context).textStyle.heading3,
                maxLines: 1,
              ),
              /*const SizedBox(height: 3,),
              Text(
                'Chest, Triceps, Shoulders',
                style: mt(context).textStyle.subtitle2,
              ),*/
              const SizedBox(
                height: 3,
              ),
              Text(
                'Description: Doing stuffs',
                style: mt(context).textStyle.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
