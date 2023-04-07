import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../theme/m_themes.dart';
import '../../program/screen/program_builder_screen.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../../workout/model/workout.dart';
import '../bloc/template/template_bloc.dart';
import '../widget/paused_workout_widget.dart';
import '../widget/templates_widget.dart';
import 'create_template_screen.dart';

/// Screen which manages templates and workouts
class TemplateScreen extends StatefulWidget {
  /// Creates a screen for managing templates and workouts
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  SliverToBoxAdapter title(String title, {double top = 32}) => SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(bottom: 13, top: top),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: mt(context).text.primaryColor,
        ),
      ),
    ),
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
              title('Quick Start', top: 0),
              SliverList(delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MButton(
                      onPressed: () {
                        context.read<WorkoutBloc>().add(WorkoutStartEmpty());
                      },
                      expand: false,
                      width: double.infinity,
                      backgroundColor: mt(context).accentColor,
                      child: Text(
                        'Start an Empty Workout',
                        style: TextStyle(
                          color: mt(context).text.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        MButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTemplateScreen(
                              onCreate: (exerciseBlocks) {
                                showBottomSheetDialog(
                                  context: context,
                                  child: TextInputDialog(
                                    title: 'Enter a Workout Name',
                                    initialValue: '',
                                    keyboardType: TextInputType.name,
                                    onValueSubmit: (value) {
                                      context.read<TemplateBloc>().add(TemplateCreate(
                                        name: value,
                                        exerciseBlocks: exerciseBlocks,
                                      ));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  onClose: () {},
                                );
                              },
                            )));
                          },
                          borderColor: mt(context).borderColor,
                          leading: Icon(
                            Icons.post_add,
                            size: 20,
                            color: mt(context).icon.accentColor,
                          ),
                          child: Text(
                            'Create Template',
                            style: TextStyle(
                              color: mt(context).text.accentColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        MButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgramBuilderScreen()));
                          },
                          borderColor: mt(context).borderColor,
                          leading: Icon(
                            Icons.polyline,
                            size: 18,
                            color: mt(context).icon.accentColor,
                          ),
                          child: Text(
                            'Program Builder',
                            style: TextStyle(
                              color: mt(context).text.accentColor,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ]),),
              
              title('In Progress'),
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
                        'Something s wrong',
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
                          'Empty',
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

              title('Templates'),
              BlocBuilder<TemplateBloc, TemplateState>(
                builder: (context, state) {
                  if(state.status.isLoading) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: CircularProgressIndicator(),
                      )
                    );
                  } else if(state.status.isLoaded) {
                    return TemplateSliverListWidget(
                      templates: state.templates,
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Text(
                        'There was an error fetching the templates.',
                        style: TextStyle(
                          color: mt(context).text.primaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}