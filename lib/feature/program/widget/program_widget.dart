import 'package:flutter/material.dart';
import 'package:maven/common/dialog/list_dialog.dart';
import 'package:maven/common/dialog/show_bottom_sheet_dialog.dart';

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
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              color: T(context).color.surface,
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
                  'M/W/F',
                ),
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
          top: 4,
          right: 4,
          child: IconButton(
            onPressed: () {
              showBottomSheetDialog(
                  context: context,
                  child: ListDialog(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          Icons.delete,
                          color: T(context).color.error,
                        ),
                        title: Text(
                          'Delete',
                          style: TextStyle(
                            color: T(context).color.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            icon: Icon(
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
