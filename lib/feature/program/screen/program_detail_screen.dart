import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/exercise/model/exercise_bundle.dart';

import '../../../database/database.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../bloc/program/program_bloc.dart';

class ProgramDetailScreen extends StatefulWidget {
  const ProgramDetailScreen({Key? key,
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
        if(state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          Program program = state.programs.firstWhere((element) => element.id == widget.programId);

          return DefaultTabController(
            length: program.folders.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  program.name,
                ),
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
                    padding: EdgeInsets.symmetric(horizontal: T(context).padding.page),
                    child: ListView.separated(
                      itemCount: templates.length + 2,
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        index -= 1;
                        if(index == -1 || index  == templates.length) {
                          return Container(
                            height: T(context).padding.page / 2,
                          );
                        }

                        ProgramTemplate template = templates[index];
                        return InkWell(
                          onTap: (){},
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: T(context).color.outline,
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  template.name,
                                  style: T(context).textStyle.titleLarge,
                                ),
                                Text(
                                  template.description,
                                  style: T(context).textStyle.titleMedium,
                                ),
                                ListView.builder(
                                  itemCount: template.exerciseBundles.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    ExerciseBundle exerciseBundle = template.exerciseBundles[index];
                                    return Text(
                                      '\u2022 ${exerciseBundle.exercise.name}',
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'There was an error fetching the program.',
            ),
          );
        }
      },
    );
  }
}
