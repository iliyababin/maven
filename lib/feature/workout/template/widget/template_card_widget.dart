import 'package:Maven/feature/workout/template/model/template.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../screen/view_template_screen.dart';

class TemplateCard extends StatelessWidget {
  final Template template;

  const TemplateCard({Key? key,
    required this.template,
  }) : super(key: key);

  final double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: mt(context).templateCard.backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: () => _showTemplate(context, template),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1,
              color: mt(context).borderColor
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        template.name,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: mt(context).text.primaryColor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1,),
                  Text(
                    'Chest, Triceps, Shoulders',
                    style: TextStyle(
                        fontSize: 15,
                        color: mt(context).text.accentColor
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Description: Doing stuff',
                    style: TextStyle(
                        fontSize: 13,
                        color: mt(context).text.secondaryColor
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
  
  ///
  /// Functions
  /// 
  
  void _showTemplate(BuildContext context, Template template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
          ViewTemplateScreen(
            template: template
          )
      )
    );
  }
}
