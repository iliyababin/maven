import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/dialog/bottom_sheet_dialog.dart';
import '../../../common/dialog/show_confirmation_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../workout/bloc/active_workout/workout_bloc.dart';
import '../../workout/model/workout.dart';
import '../bloc/template/template_bloc.dart';
import '../model/template.dart';
import '../model/template_folder.dart';
import '../widget/template_folder_widget.dart';
import 'create_template_screen.dart';
import 'reorder_template_screen.dart';


class TemplateScreen extends StatefulWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {

  @override
  void initState() {
    super.initState();
  }

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

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Workouts
            BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if(state.status == WorkoutStatus.loading) {
                  return SliverList(delegate: SliverChildListDelegate([]),);
                } else if (state.status == WorkoutStatus.none || state.status == WorkoutStatus.active) {
                  List<Workout> pausedWorkouts = state.pausedWorkouts;

                  return pausedWorkouts.isEmpty
                      ?
                  SliverList(delegate: SliverChildListDelegate([]))
                    :
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: pausedWorkouts.length,
                        (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: mt(context).templateFolder.backgroundColor,
                            child: InkWell(
                              onTap: () async {
                                if(context.read<WorkoutBloc>().state.status == WorkoutStatus.active) {
                                  bool? confirmation = await showConfirmationDialog(
                                      context: context,
                                      title: 'Workout in progress',
                                      subtext: 'You already have a workout in progress, would you like to delete it?'
                                  );
                                  if(confirmation == null) return;
                                  if(!confirmation) return;
                                  context.read<WorkoutBloc>().add(WorkoutDelete());
                                }
                                context.read<WorkoutBloc>().add(WorkoutUnpause(workout: pausedWorkouts[index]));
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: mt(context).borderColor
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            pausedWorkouts[index].name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: mt(context).text.primaryColor
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      StreamBuilder(
                                        stream: Stream.periodic(Duration(minutes: 1)),
                                        builder: (context, snapshot) {
                                          return Text('Created ${timeago.format(pausedWorkouts[index].timestamp)}');
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text("nothign here");
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
                              onPressed: () => _createTemplateFolder(context),
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
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  List<TemplateFolder> templateFolders = state.templateFolders;
                  List<Template> templates = state.templates;

                  if(templateFolders.isEmpty) {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: 500,
                          child: Image.asset('assets/icons8-document-440.png'),
                        )
                      ]),
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
                                templates: templates.where((template) => template.templateFolderId == templateFolders[index].templateFolderId).toList()
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



            /*Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                BlocBuilder<WorkoutBloc, WorkoutState>(
                  builder: (context, state) {
                    if(state.status == WorkoutStatus.loading) {
                      return Container();
                    } else if (state.status == WorkoutStatus.none || state.status == WorkoutStatus.active) {
                      List<Workout> pausedWorkouts = state.pausedWorkouts;

                      return pausedWorkouts.isEmpty
                          ?
                      Container()
                          :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              'In Progress',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: mt(context).text.primaryColor
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: pausedWorkouts.length,
                              itemBuilder: (context, index) {
                                Workout pausedWorkout = pausedWorkouts[index];
                                return Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mt(context).templateFolder.backgroundColor,
                                  child: InkWell(
                                    onTap: () async {
                                      if(context.read<WorkoutBloc>().state.status == WorkoutStatus.active) {
                                        bool? confirmation = await showConfirmationDialog(
                                            context: context,
                                            title: 'Workout in progress',
                                            subtext: 'You already have a workout in progress, would you like to delete it?'
                                        );
                                        if(confirmation == null) return;
                                        if(!confirmation) return;
                                        context.read<WorkoutBloc>().add(WorkoutDelete());
                                      }
                                      context.read<WorkoutBloc>().add(WorkoutUnpause(workout: pausedWorkout));
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: mt(context).borderColor
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  pausedWorkout.name,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: mt(context).text.primaryColor
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            StreamBuilder(
                                              stream: Stream.periodic(Duration(minutes: 1)),
                                              builder: (context, snapshot) {
                                                return Text('Created ${timeago.format(pausedWorkout.timestamp)}');
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: 9,);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text("nothign here");
                    }
                  },
                ),
                const SizedBox(height: 25,),
                templates(),
                BlocBuilder<TemplateBloc, TemplateState>(
                  buildWhen: (previous, current) {
                    if(current.status == TemplateStatus.toggle) return false;
                    return true;
                  },
                  builder: (context, state) {
                    if (state.status == TemplateStatus.loading) {
                      return const SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator())
                      );
                    } else {
                      List<TemplateFolder> templateFolders = state.templateFolders;
                      List<Template> templates = state.templates;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ReorderableListView(

                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          proxyDecorator: proxyDecorator,
                          children: templateFolders.map((templateFolder) {
                            return Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                              child: TemplateFolderWidget(
                                  templateFolder: templateFolder,
                                  templates: templates.where((template) =>
                                  template.templateFolderId == templateFolder.templateFolderId
                                  ).toList()
                              ),
                            );
                          }).toList(),
                          onReorder: (int oldIndex, int newIndex) => _reorder(oldIndex, newIndex, templateFolders),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 200,)
              ],
            )*/
          ],
        )
      ),
    );
  }

  Future<void> _createTemplateFolder(BuildContext context) async {
    /*String? result = await showDialogWithTextField(
        context: context,
        title: 'Create New Folder',
        hintText: "Folder Name"
    );
    if (result != null) {
      final templateFolder = TemplateFolder(name: result, expanded: 1);
      context.read<TemplateBloc>().add(TemplateFolderAdd(
          templateFolder: templateFolder
      ));
    }*/
    showBottomSheetDialog(
      context: context,
      child: TextInputDialog(
        onValueChanged: (String value) {
        },
        hintText: 'eg. Workouts',
        title: 'Create new folder',
        initialValue: '',
        onValueSubmit: (value) {
          final templateFolder = TemplateFolder(name: value, expanded: 1);
          context.read<TemplateBloc>().add(TemplateFolderAdd(
              templateFolder: templateFolder
          ));
        },
      ),
      onClose: () {  },
    );
/*
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [

               ],
             ),
           )
          ],
        );
      },
    );*/

  }

  ///
  /// Widgets
  ///
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

/*

  @override
  Widget build(BuildContext context) {


    return CustomScaffold.build(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => _navigateToCreateTemplateScreen(context),
            child: const Text("Create Template"),
          ),
          const Text("Paused templates:"),
          Flexible(
            fit: FlexFit.tight,
            child: Consumer<ActiveTemplateProvider>(
              builder: (context, activeTemplateProvider, child) {
                if(activeTemplateProvider.pausedActiveTemplates.length == 0 ){
                  print("emptyu");
                  return Container();
                }
                return ListView(
                  children: activeTemplateProvider.pausedActiveTemplates.map((
                      activeTemplate) {
                    return ListTile(
                      onTap: () {
                        unpauseTemplate(
                            context, activeTemplate.activeTemplateId!);
                      },
                      title: Text(activeTemplate.name),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Text("Template templates:"),
          BlocBuilder<TemplateBloc, TemplateState>(
            builder: (context, state) {
              if (state.status == TemplateStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == TemplateStatus.success) {

                final templates = state.templates;
                return Expanded(
                  child: ListView.builder(
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      final template = templates[index];

                      return ListTile(
                        title: Text(template.name),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewTemplateScreen(
                                          templateId: template.templateId!
                                      )
                              )
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Text("lol");
              }
            },
          )
        ],
      ),
      context: context,
    );
  }
*/
/*templateProvider.templates.map((template) {
return Dismissible(
key: UniqueKey(),
onDismissed: (direction) {
Provider.of<TemplateProvider>(context, listen: false)
    .deleteTemplate(template.templateId!);
},
child: ListTile(
onTap: () async {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => ViewTemplateScreen(
templateId: template.templateId!
)
)
);
},
title: Text(template.name),
subtitle: Text(template.templateId.toString()),
),
);
}).toList()*/
