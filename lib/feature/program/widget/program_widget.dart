import 'package:flutter/material.dart';
import 'package:maven/common/widget/m_button.dart';

import '../../../database/database.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../screen/program_detail_screen.dart';

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({
    Key? key,
    required this.program,
  }) : super(key: key);

  final Program program;

  final double _borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgramDetailScreen(programId: program.id!),
                ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: Border.all(
                color: T(context).color.outline,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name,
                  style: T(context).textStyle.titleLarge,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Template',
                  style: T(context).textStyle.titleSmall,
                ),
                /*Text(
                'Week 2 of ${program.weeks}',
                style: T(context).textStyle.titleMedium.copyWith(color: T(context).color.primary),
              ),*/
                const SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: program.folders.first.templates.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final ProgramTemplate template = program.folders.first.templates[index];
                      return Text(
                        '\u2022 ${template.name}',
                        style: T(context).textStyle.bodyLarge,
                      );
                    },
                  ),
                )
                /*const SizedBox(
                height: 3,
              ),
              Text(
                'This an example desciption of the program This an example desciption of the program This an example desciption of the program',
                style: T(context).textStyle.subtitle1,
              )*/
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: MButton(
            onPressed: () {},
            width: 28,
            height: 22,
            borderRadius: 8,
            backgroundColor: T(context).color.primaryContainer,
            child: Icon(
              Icons.more_horiz,
              color: T(context).color.primary,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
