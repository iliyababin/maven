import 'package:Maven/common/theme/app_themes.dart';
import 'package:Maven/feature/workout/bloc/workout/workout_bloc.dart';
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
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Workout'),
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
                    const Text(
                      "Quick Start",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double?>(0),
                                backgroundColor: MaterialStateProperty.all<Color>(colors(context).accentTextColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 8,),
                                  Text(
                                    'Start an Empty Workout',
                                    style: TextStyle(
                                      color: colors(context).whiteColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(colors(context).backgroundColor,),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        width: 1, // thickness
                                        color: colors(context).backgroundDarkColor // color
                                    ),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double?>(0),

                                overlayColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    return states.contains(MaterialState.pressed)
                                        ? colors(context).backgroundDarkColor
                                        : null;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      Icons.post_add,
                                      color: colors(context).accentTextColor
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    'Create Template',
                                    style: TextStyle(
                                      color: colors(context).accentTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(colors(context).backgroundColor,),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        width: 1, // thickness
                                        color: colors(context).backgroundDarkColor // color
                                    ),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double?>(0),

                                overlayColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    return states.contains(MaterialState.pressed)
                                        ? colors(context).backgroundDarkColor
                                        : null;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      Icons.polyline,
                                      color: colors(context).accentTextColor
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    'Workout Builder',
                                    style: TextStyle(
                                      color: colors(context).accentTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Workouts",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
              SizedBox(height: 8,),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if (state.status == WorkoutStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == WorkoutStatus.success) {

                    final workouts = state.workouts;
                    return ListView.builder(
                      itemCount: workouts.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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

  _navigateToCreateWorkoutScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CreateWorkoutScreen()
        )
    );
  }
}

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