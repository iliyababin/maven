import 'package:Maven/feature/program/screen/program_detail_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../common/util/general_utils.dart';
import '../../../database/model/program.dart';

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({Key? key,
    required this.program,
  }) : super(key: key);

  final Program program;

  final double _borderRadius = 10;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: mt(context).color.background,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramDetailScreen(programId: program.programId!),));
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
                program.name,
                style: mt(context).textStyle.heading3,
                maxLines: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '10 weeks | ${formatDate(program.createdAt)} - ${formatDate(program.createdAt.add(Duration(days: program.weeks * 7)))}',
                style: mt(context).textStyle.subtitle2,
              ),
              /*const SizedBox(
                height: 3,
              ),
              Text(
                'This an example desciption of the program This an example desciption of the program This an example desciption of the program',
                style: mt(context).textStyle.subtitle1,
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
