import 'package:Maven/common/dialog/show_text_input_dialog.dart';
import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/feature/workout/bloc/workout/workout_bloc.dart';
import 'package:Maven/feature/workout/screen/reorder_workout_screen.dart';
import 'package:Maven/feature/workout/widget/workout_folder_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_workout_screen.dart';
import 'view_workout_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              quickStart(),
              workouts(),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if (state.status == WorkoutStatus.loading) {
                    return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator())
                    );
                  } else if (state.status == WorkoutStatus.success) {
                    List<WorkoutFolder> workoutFolders = state.workoutFolders;
                    List<Workout> workouts = state.workouts;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: workoutFolders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return WorkoutFolderWidget(
                            workoutFolder: workoutFolders[index],
                            workouts: workouts.where((workout) =>
                            workout.workoutFolderId == workoutFolders[index].workoutFolderId).toList()
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('There was an error');
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  ///
  /// Functions
  ///

  _showWorkout(BuildContext context, Workout workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
          ViewWorkoutScreen(
              workoutId: workout.workoutId!
          )
      )
    );
  }

  _createWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateWorkoutScreen()
      )
    );
  }

  _reorderWorkouts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReorderWorkoutScreen()
      )
    );
  }

  ///
  /// Widgets
  ///

  Padding quickStart() =>
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Start',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: mt(context).text.primaryColor
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
                    fontWeight: FontWeight.w700
                  ),
                ),
                backgroundColor: mt(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 12,
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
                icon: Icon(
                  Icons.post_add,
                  size: 20,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _createWorkout(context),
              ),
              const SizedBox(width: 16),
              MFlatButton(
                text: Text(
                  'Workout Builder',
                  style: TextStyle(
                    color: mt(context).text.accentColor,
                    fontSize: 15,
                  ),
                ),
                borderColor: mt(context).borderColor,
                icon: Icon(
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
  );

  Padding workouts() =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Workouts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: mt(context).text.primaryColor),
          ),
          Row(
            children: [
              MFlatButton(
                width: 35,
                height: 35,
                expand: false,
                padding: const EdgeInsets.all(5),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  size: 20,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _reorderWorkouts(context),
              ),
              const SizedBox(
                width: 8,
              ),
              MFlatButton(
                width: 35,
                height: 35,
                expand: false,
                padding: const EdgeInsets.all(5),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  Icons.create_new_folder_rounded,
                  size: 22,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _createWorkoutFolder(context),
              ),
            ],
          )
        ],
      ),
    );

  ///
  /// Functions
  ///

  Future<void> _createWorkoutFolder(BuildContext context) async {
    String? result = await showDialogWithTextField(
        context: context,
        title: 'Create New Folder',
        hintText: "Folder Name"
    );
    if (result != null) {
      final workoutFolder = WorkoutFolder(name: result);
      context.read<WorkoutBloc>().add(AddWorkoutFolder(
          workoutFolder: workoutFolder
      ));
    }
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
            onPressed: () => _navigateToCreateWorkoutScreen(context),
            child: const Text("Create Workout"),
          ),
          const Text("Paused workouts:"),
          Flexible(
            fit: FlexFit.tight,
            child: Consumer<ActiveWorkoutProvider>(
              builder: (context, activeWorkoutProvider, child) {
                if(activeWorkoutProvider.pausedActiveWorkouts.length == 0 ){
                  print("emptyu");
                  return Container();
                }
                return ListView(
                  children: activeWorkoutProvider.pausedActiveWorkouts.map((
                      activeWorkout) {
                    return ListTile(
                      onTap: () {
                        unpauseWorkout(
                            context, activeWorkout.activeWorkoutId!);
                      },
                      title: Text(activeWorkout.name),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Text("Workout templates:"),
          BlocBuilder<WorkoutBloc, WorkoutState>(
            builder: (context, state) {
              if (state.status == WorkoutStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == WorkoutStatus.success) {

                final workouts = state.workouts;
                return Expanded(
                  child: ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];

                      return ListTile(
                        title: Text(workout.name),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewWorkoutScreen(
                                          workoutId: workout.workoutId!
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
/*workoutProvider.workouts.map((workout) {
return Dismissible(
key: UniqueKey(),
onDismissed: (direction) {
Provider.of<WorkoutProvider>(context, listen: false)
    .deleteWorkout(workout.workoutId!);
},
child: ListTile(
onTap: () async {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => ViewWorkoutScreen(
workoutId: workout.workoutId!
)
)
);
},
title: Text(workout.name),
subtitle: Text(workout.workoutId.toString()),
),
);
}).toList()*/
