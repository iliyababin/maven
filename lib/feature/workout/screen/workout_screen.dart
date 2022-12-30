import 'package:Maven/common/util/provider/active_workout_provider.dart';
import 'package:Maven/common/util/workout_manager.dart';
import 'package:Maven/feature/workout/bloc/workout/workout_bloc.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state) {
        print("nice");
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("got here"),
            ),
          );
      },
      child: CustomScaffold.build(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToCreateWorkoutScreen(context),
              child: const Text("Create Workout"),
            ),
            const Text("Paused workouts:"),
            Expanded(
              child: Consumer<ActiveWorkoutProvider>(
                builder: (context, activeWorkoutProvider, child) {
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
                if (state is WorkoutInitial) {
                  return const CircularProgressIndicator();
                } else if (state is WorkoutLoaded) {
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
      ),
    );
  }

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