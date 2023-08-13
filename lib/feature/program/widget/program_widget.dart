import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../program.dart';


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
                const Text(
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
                ),
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
                        context.read<ProgramBloc>().add(ProgramDelete(
                              program: program,
                            ));
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
                ),
              );
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
