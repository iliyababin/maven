import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/theme/app_themes.dart';
import 'package:Maven/feature/workout/bloc/workout/workout_bloc.dart';
import 'package:Maven/feature/workout/widget/workout_card.dart';
import 'package:Maven/widget/flat_button.dart';
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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: colors(context).backgroundColor,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Workout',
                style: TextStyle(
                  color: colors(context).primaryTextColor,
                ),
              ),
              backgroundColor: colors(context).backgroundColor,
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Start",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colors(context).primaryTextColor
                      ),
                    ),
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        FlatButton(
                          text: Text(
                            "Start an Empty Workout",
                            style: TextStyle(
                              color: colors(context).whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          color: colors(context).accentTextColor,
                          showIcon: false,
                          onPressed: (){},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      children: [
                        FlatButton(
                          text: Text(
                            "Create Template",
                            style: TextStyle(
                                color: colors(context).accentTextColor,
                                fontSize: 15,
                            ),
                          ),
                          color: colors(context).backgroundColor,
                          borderColor: colors(context).backgroundDarkColor,
                          showIcon: true,
                          icon: Icon(
                            Icons.post_add,
                            size: 20,
                            color: colors(context).accentTextColor,
                          ),
                          onPressed: () => _createWorkout(context),
                        ),
                        const SizedBox(width: 16),
                        FlatButton(
                          text: Text(
                            "Workout Builder",
                            style: TextStyle(
                              color: colors(context).accentTextColor,
                              fontSize: 15,
                            ),
                          ),
                          color: colors(context).backgroundColor,
                          borderColor: colors(context).backgroundDarkColor,
                          showIcon: true,
                          icon: Icon(
                            Icons.polyline,
                            size: 18,
                            color: colors(context).accentTextColor,
                          ),
                          onPressed: ( ) {

                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Workouts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: colors(context).primaryTextColor
                  ),
                ),
              ),
              const SizedBox(height: 14,),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if (state.status == WorkoutStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == WorkoutStatus.success) {

                    final workouts = state.workouts;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        itemCount: workouts.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final workout = workouts[index];

                          return WorkoutCard(
                            workout: workout,
                            backgroundColor: colors(context).backgroundColor,
                            borderColor: colors(context).backgroundDarkColor,
                            accentColor: colors(context).accentTextColor,
                              primaryTextColor: colors(context).primaryTextColor,
                            onTap: () {
                              _showWorkout(context, workout);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 10,);
                        },
                      ),
                    );
                  } else {
                    return const Text("lol");
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  _showWorkout(BuildContext context, Workout workout) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
        ViewWorkoutScreen(
            workoutId: workout.workoutId!
        )
      )
    );
  }
  _createWorkout(BuildContext context) {
    print("Heyere");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
        const CreateWorkoutScreen()
      )
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