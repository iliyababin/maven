import 'package:flutter/material.dart';

import '../../../common/widget/m_button.dart';
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
    return MButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTemplateScreen(
          template: template,
        )));
      },
      height: 90,
      expand: false,
      borderRadius: _borderRadius,
      borderColor: mt(context).borderColor,
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
                    color: mt(context).text.primaryColor,
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
          ],
        ),
      ),
    );
  }
}
