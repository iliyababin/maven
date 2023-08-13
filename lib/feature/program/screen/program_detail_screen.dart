import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../program.dart';

class ProgramDetailScreen extends StatefulWidget {
  const ProgramDetailScreen({
    Key? key,
    required this.programId,
  }) : super(key: key);

  final int programId;

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          Program program =
          state.programs.firstWhere((element) => element.id == widget.programId);

          if (program.folders.length == 1) {
            // Display just the list of templates when there's only one folder
            List<ProgramTemplate> templates = program.folders[0].templates;

            return Scaffold(
              appBar: AppBar(
                title: Text(program.name),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
                child: ListView.separated(
                  itemCount: templates.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ProgramTemplateWidget(
                      onTap: () {
                      },
                      programTemplate: templates[index],
                      onEdit: (programTemplate) {
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return DefaultTabController(
              length: program.folders.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(program.name),
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    tabs: program.folders.map((e) {
                      return Tab(
                        text: 'Week ${e.order}',
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children: program.folders.map((e) {
                    List<ProgramTemplate> templates = e.templates;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
                      child: ListView.separated(
                        itemCount: templates.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: index == 0 ? 16 : 0, bottom: index == templates.length - 1 ? 16 : 0),
                            child: ProgramTemplateWidget(
                              onTap: () {

                              },
                              programTemplate: templates[index],
                              onEdit: (programTemplate) {

                              },
                              extended: true,
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
        } else {
          return const Center(
            child: Text(
              'There was an error fetching the program details.',
            ),
          );
        }
      },
    );
  }
}
