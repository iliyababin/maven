import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/program/widget/program_template_widget.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../common/widget/heading.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../template/template.dart';
import '../bloc/program/program_bloc.dart';

class ProgramBuilderScreen extends StatefulWidget {
  const ProgramBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends State<ProgramBuilderScreen> {
  late Program program;
  late List<ProgramTemplate> programTemplates;

  @override
  void initState() {
    program = Program(
      name: 'A program',
      weeks: 10,
      timestamp: DateTime.now(),
    );
    programTemplates = [];
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
                  programTemplates: programTemplates,
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
              sliver: SliverReorderableGrid(
                itemCount: programTemplates.length + 1,
                proxyDecorator: (widget, index, animation) {
                  // add shadow and change scale during drag
                  final scale = Tween<double>(begin: 1, end: 1.05).animate(animation);
                  final shadow = BoxShadow(
                    color: T(context).color.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  );
                  return ScaleTransition(
                    scale: scale,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [shadow],
                      ),
                      child: widget,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                onReorder: (oldIndex, newIndex) {
                  if (newIndex == programTemplates.length) return;
                  setState(() {
                    final ProgramTemplate bundle = programTemplates.removeAt(oldIndex);
                    programTemplates.insert(newIndex, bundle);
                  });
                },
                itemBuilder: (context, index) {
                  if (index == programTemplates.length) {
                    return MButton(
                      key: const ValueKey('add'),
                      expand: false,
                      borderColor: T(context).color.outline,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTemplateScreen(
                              onSubmit: (template, exerciseBundles) {
                                setState(() {
                                  programTemplates.add(
                                    ProgramTemplate(
                                      name: template.name,
                                      description: template.description,
                                      timestamp: DateTime.now(),
                                      complete: false,
                                      day: Day.monday,
                                      folderId: -1,
                                      exerciseBundles: exerciseBundles,
                                    ),
                                  );
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_outlined,
                        size: 36,
                      ),
                    );
                  }

                  return ReorderableGridDelayedDragStartListener(
                    key: ValueKey(programTemplates[index].id),
                    index: index,
                    child: ProgramTemplateWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTemplateScreen(
                              onSubmit: (template, exerciseBundles) {
                                setState(
                                      () {
                                    programTemplates[index] = ProgramTemplate(
                                      name: template.name,
                                      description: template.description,
                                      timestamp: DateTime.now(),
                                      complete: false,
                                      day: programTemplates[index].day,
                                      folderId: -1,
                                      exerciseBundles: exerciseBundles,
                                    );
                                  }
                                );
                                Navigator.pop(context);
                              },
                              template: Template(
                                name: programTemplates[index].name,
                                description: programTemplates[index].description,
                                sort: -1,
                                timestamp: programTemplates[index].timestamp,
                              ),
                              exerciseBundles: programTemplates[index].exerciseBundles,
                            ),
                          ),
                        );
                      },
                      programTemplate: programTemplates[index],
                    ),
                  );
                },
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
