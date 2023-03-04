import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../theme/m_themes.dart';
import '../../../widget/m_flat_button.dart';
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
        body: CustomScrollView(
          slivers: [

            // Quick start
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Start',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: mt(context).text.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          MFlatButton(
                            text: Text(
                              'Start an Empty Workout',
                              style: TextStyle(
                                color: mt(context).text.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            backgroundColor: mt(context).accentColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          MFlatButton(
                            text: Text(
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTemplateScreen()));
                            },
                          ),
                          const SizedBox(width: 14),
                          MFlatButton(
                            text: Text(
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
                ),
              ]),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Workouts header
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'In Progress',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: mt(context).text.primaryColor,
                    ),
                  ),
                ),
              ]),
            ),

            // Workouts
            BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if(state.status == WorkoutStatus.loading) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else if (state.status == WorkoutStatus.error) {
                  return const Text(
                    'Something went wrong',
                  );
                } else {
                  List<Workout> workouts = state.pausedWorkouts;

                  return workouts.isEmpty
                      ?
                  SliverToBoxAdapter(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        border: Border.all(
                          color: mt(context).borderColor
                        )
                      ),
                      alignment: FractionalOffset.center,
                      child: Text(
                        'Paused workouts will appear here',
                        style: TextStyle(
                          color: mt(context).text.secondaryColor,
                          fontSize: 14
                        ),
                      ),
                    ),
                  )
                    :
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.all(15),
                    sliver: SliverList(
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
                    ),
                  );
                }
              },
            ),

            // Template header
            SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Templates',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: mt(context).text.primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            MFlatButton(
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
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReorderTemplateScreen()));
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            MFlatButton(
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
                              onPressed: () => showBottomSheetDialog(
                                context: context,
                                child: TextInputDialog(
                                  title: 'Enter a folder name',
                                  initialValue: '',
                                  hintText: 'eg. Mondays workouts',
                                  keyboardType: TextInputType.name,
                                  onValueSubmit: (value) {
                                    context.read<TemplateBloc>().add(TemplateFolderAdd(
                                        name: value
                                    ));
                                  },
                                ),
                                onClose: (){}
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ])
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Templates
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
                    return SliverList(
                      delegate: SliverChildListDelegate([]),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: templateFolders.length,
                      (context, index) {
                        return Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: ReorderableDelayedDragStartListener(
                            index: index,
                            child: TemplateFolderWidget(
                              templateFolder: templateFolders[index],
                              templates: templates.where((template) => template.templateFolderId == templateFolders[index].templateFolderId).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),

          ],
        )
      ),
    );
  }

  /// Creates a shadow underneath item when reordering.
  /// Accounts for padding.
  ///
  /// [Source](https://github.com/flutter/flutter/issues/76706#issuecomment-986181379)
  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 14,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 5,
                  shadowColor: mt(context).templateFolder.dragShadowColor,
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: child,
    );
  }
}