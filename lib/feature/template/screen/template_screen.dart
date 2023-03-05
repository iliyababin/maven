import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../theme/m_themes.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../../workout/model/workout.dart';
import '../bloc/template/template_bloc.dart';
import '../model/template.dart';
import '../model/template_folder.dart';
import '../widget/paused_workout_widget.dart';
import '../widget/template_folder_widget.dart';
import 'create_template_screen.dart';
import 'reorder_template_screen.dart';

/// Screen which manages templates and workouts
class TemplateScreen extends StatefulWidget {
  /// Creates a screen for managing templates and workouts
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  Padding headerText(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 13, top: 13),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: mt(context).text.primaryColor,
      ),
    ),
  );

  /// **Note:** For consistency, make sure the surrounding widgets take up the least amount of space possible.
  Widget divider() => const SliverToBoxAdapter(
    child: SizedBox(height: 25),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: mt(context).backgroundColor,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Workout',
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                ),
              ),
              backgroundColor: mt(context).sliverNavigationBarBackgroundColor,
            )
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(mt(context).sidePadding),
          child: CustomScrollView(
            slivers: [
              // Quick start
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText('Quick Start'),
                      MButton(
                        onPressed: () {
                          context.read<WorkoutBloc>().add(WorkoutStartEmpty());
                        },
                        child: Text(
                          'Start an Empty Workout',
                          style: TextStyle(
                            color: mt(context).text.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        expand: false,
                        width: double.infinity,
                        backgroundColor: mt(context).accentColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          MButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTemplateScreen()));
                            },
                            child: Text(
                              'Create Template',
                              style: TextStyle(
                                color: mt(context).text.accentColor,
                                fontSize: 15,
                              ),
                            ),
                            borderColor: mt(context).borderColor,
                            leading: Icon(
                              Icons.post_add,
                              size: 20,
                              color: mt(context).icon.accentColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          MButton(
                            child: Text(
                              'Template Builder',
                              style: TextStyle(
                                color: mt(context).text.accentColor,
                                fontSize: 15,
                              ),
                            ),
                            borderColor: mt(context).borderColor,
                            leading: Icon(
                              Icons.polyline,
                              size: 18,
                              color: mt(context).icon.accentColor,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ]),
              ),

              divider(),

              // Workouts
              SliverToBoxAdapter(
                child: headerText('In Progress'),
              ),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if(state.status == WorkoutStatus.loading) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.status == WorkoutStatus.error) {
                    return SliverToBoxAdapter(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: mt(context).text.errorColor,
                        ),
                      ),
                    );
                  } else {
                    List<Workout> workouts = state.pausedWorkouts;

                    return workouts.isEmpty
                        ?
                    SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          border: Border.all(
                            color: mt(context).borderColor
                          )
                        ),
                        alignment: FractionalOffset.center,
                        child: Text(
                          'No paused workouts',
                          style: TextStyle(
                            color: mt(context).text.secondaryColor,
                            fontSize: 14
                          ),
                        ),
                      ),
                    )
                      :
                    SliverList(
                      /// [SliverList] with [SizedBox] dividers between [PausedWorkoutWidget]s
                      ///
                      /// Mimics a [ListView.separated] since there's no SliverList.separated
                      ///
                      /// [Source](https://stackoverflow.com/a/58176779)
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final int itemIndex = index ~/ 2;
                          if (index.isEven) {
                            return PausedWorkoutWidget(workout: workouts[itemIndex]);
                          }
                          return const SizedBox(height: 15);
                        },
                        semanticIndexCallback: (Widget widget, int localIndex) {
                          if (localIndex.isEven) {
                            return localIndex ~/ 2;
                          }
                          return null;
                        },
                        childCount: max(0, workouts.length * 2 - 1),
                      ),
                    );
                  }
                },
              ),

              divider(),

              // Templates
              SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      headerText('Templates'),
                      Row(
                        children: [
                          MButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReorderTemplateScreen()));
                            },
                            width: 40,
                            height: 40,
                            expand: false,
                            padding: const EdgeInsets.all(5),
                            borderColor: mt(context).borderColor,
                            leading: Icon(
                              CupertinoIcons.arrow_up_arrow_down,
                              size: 20,
                              color: mt(context).icon.accentColor,
                            ),
                            backgroundColor: mt(context).templateFolder.backgroundColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          MButton(
                            onPressed: () => showBottomSheetDialog(
                              context: context,
                              child: TextInputDialog(
                                title: 'Create New Folder',
                                initialValue: '',
                                hintText: 'eg. Mondays Workouts',
                                keyboardType: TextInputType.name,
                                onValueSubmit: (value) {
                                  context.read<TemplateBloc>().add(TemplateFolderAdd(
                                      name: value
                                  ));
                                },
                              ),
                              onClose: (){},
                            ),
                            width: 40,
                            height: 40,
                            expand: false,
                            padding: const EdgeInsets.all(5),
                            borderColor: mt(context).borderColor,
                            leading: Icon(
                              Icons.create_new_folder_rounded,
                              size: 22,
                              color: mt(context).icon.accentColor,
                            ),
                            backgroundColor: mt(context).templateFolder.backgroundColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,)
                ]),
              ),
              BlocBuilder<TemplateBloc, TemplateState>(
                buildWhen: (previous, current) {
                  if(current.status == TemplateStatus.toggle) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state.status == TemplateStatus.loading) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  } else {
                    List<TemplateFolder> templateFolders = state.templateFolders;
                    List<Template> templates = state.templates;

                    if(templateFolders.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            border: Border.all(
                              color: mt(context).borderColor,
                            ),
                          ),
                          padding: const EdgeInsetsDirectional.all(100),
                          alignment: FractionalOffset.center,
                          child: Text(
                            'Empty',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mt(context).text.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      /// [SliverList] with [SizedBox] dividers between [PausedWorkoutWidget]s
                      ///
                      /// Mimics a [ListView.separated] since there's no SliverList.separated
                      ///
                      /// [Source](https://stackoverflow.com/a/58176779)
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final int itemIndex = index ~/ 2;
                          if (index.isEven) {
                            return TemplateFolderWidget(
                              templateFolder: templateFolders[itemIndex],
                              templates: templates.where((template) => template.templateFolderId == templateFolders[itemIndex].templateFolderId).toList(),
                            );
                          }
                          return const SizedBox(height: 15);
                        },
                        semanticIndexCallback: (Widget widget, int localIndex) {
                          if (localIndex.isEven) {
                            return localIndex ~/ 2;
                          }
                          return null;
                        },
                        childCount: max(0, templateFolders.length * 2 - 1),
                      ),
                    );
                  }
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 180)),
            ],
          ),
        )
      ),
    );
  }
}