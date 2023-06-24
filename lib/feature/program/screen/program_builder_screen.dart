import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/list_dialog.dart';
import 'package:maven/common/extension.dart';
import 'package:maven/feature/program/screen/day_selector_screen.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../common/widget/heading.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../template/template.dart';
import '../bloc/program/program_bloc.dart';
import '../model/program_template_bundle.dart';

class ProgramBuilderScreen extends StatefulWidget {
  const ProgramBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends State<ProgramBuilderScreen> {
  late Program program;
  late List<ProgramTemplateBundle> programTemplateBundles;

  @override
  void initState() {
    program = Program(
      name: 'A program',
      weeks: 10,
      timestamp: DateTime.now(),
    );
    programTemplateBundles = [
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Program Builder',
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ProgramBloc>().add(ProgramBuild(
                  program: program,
                  programTemplateBundles: programTemplateBundles,
                ));
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check_rounded,
              ),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Basic',
              topPadding: false,
              side: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: const Icon(
                    Icons.drive_file_rename_outline_rounded,
                  ),
                  onTap: () {
                    showBottomSheetDialog(
                      context: context,
                      child: TextInputDialog(
                        title: 'Name',
                        initialValue: program.name,
                        keyboardType: TextInputType.name,
                        onValueSubmit: (value) {
                          setState(() {
                            program = program.copyWith(name: value);
                          });
                        },
                      ),
                      onClose: () {},
                    );
                  },
                  title: const Text(
                    'Name',
                  ),
                  trailing: Text(
                    program.name,
                  ),
                ),
                ListTile(
                  onTap: () {
                    showBottomSheetDialog(
                      context: context,
                      child: TextInputDialog(
                        title: 'Weeks',
                        initialValue: program.weeks.toString(),
                        keyboardType: TextInputType.number,
                        onValueSubmit: (value) {
                          setState(() {
                            program = program.copyWith(weeks: int.parse(value));
                          });
                        },
                      ),
                      onClose: () {},
                    );
                  },
                  leading: const Icon(
                    Icons.calendar_month_rounded,
                  ),
                  title: const Text('Weeks'),
                  trailing: Text(
                    program.weeks.toString(),
                  ),
                ),
              ]),
            ),
            const Heading(
              title: 'Templates',
              side: true,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: T(context).padding.page),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: programTemplateBundles.length + 1,
                  (context, index) {
                    if (index == programTemplateBundles.length) {
                      return MButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTemplateScreen(
                                onSubmit: (template, exerciseBundles) {
                                  setState(
                                    () {
                                      programTemplateBundles.add(
                                        ProgramTemplateBundle(
                                          programTemplate: ProgramTemplate(
                                            name: template.name,
                                            description: template.description,
                                            timestamp: DateTime.now(),
                                            complete: false,
                                            day: Day.monday,
                                            folderId: -1,
                                          ),
                                          exerciseBundles: exerciseBundles,
                                        ),
                                      );
                                    },
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        expand: false,
                        mainAxisAlignment: MainAxisAlignment.center,
                        borderColor: T(context).color.outline,
                        borderRadius: 16,
                        padding: const EdgeInsets.all(16),
                        child: const Icon(
                          Icons.add_rounded,
                          size: 32,
                        ),
                      );
                    }

                    final ProgramTemplateBundle bundle = programTemplateBundles[index];

                    return Stack(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: T(context).color.outline,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bundle.programTemplate.name,
                                  style: T(context).textStyle.titleLarge,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DaySelectorScreen(
                                          day: bundle.programTemplate.day,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          programTemplateBundles[index].programTemplate = programTemplateBundles[index].programTemplate.copyWith(day: value);
                                        });
                                      }
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    bundle.programTemplate.day.name.capitalize(),
                                    style: T(context).textStyle.subtitle2.copyWith(
                                          color: T(context).color.primary,
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Expanded(
                                  child: ListView(
                                    children: bundle.exerciseBundles
                                        .map(
                                          (e) => Text(
                                            '\u2022 ${e.exercise.name}',
                                            style: T(context).textStyle.bodyLarge,
                                            maxLines: 1,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTemplateScreen(
                                  onSubmit: (template, exerciseBundles) {
                                    setState(
                                      () {
                                        programTemplateBundles[index] = ProgramTemplateBundle(
                                          programTemplate: ProgramTemplate(
                                            name: template.name,
                                            description: template.description,
                                            timestamp: DateTime.now(),
                                            complete: false,
                                            day: bundle.programTemplate.day,
                                            folderId: -1,
                                          ),
                                          exerciseBundles: exerciseBundles,
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                  },
                                  template: Template(
                                    name: bundle.programTemplate.name,
                                    description: bundle.programTemplate.description,
                                    sort: -1,
                                    timestamp: bundle.programTemplate.timestamp,
                                  ),
                                  exerciseBundles: bundle.exerciseBundles,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: IconButton(
                            onPressed: () {
                              showBottomSheetDialog(
                                context: context,
                                child: ListDialog(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          programTemplateBundles.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(
                                        Icons.delete,
                                        color: T(context).color.error,
                                      ),
                                      title: const Text(
                                        'Delete',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.more_horiz_outlined,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const Heading(
              title: 'Incrementers',
              side: true,
            ),
          ],
        ),
      ),
    );
  }
}
