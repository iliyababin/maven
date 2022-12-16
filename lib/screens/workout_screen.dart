import 'package:flutter/material.dart';
import 'package:maven/screens/log_screen.dart';

import '../data/data.dart';
import '../widgets/titled_section.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: TitledSection(
          title: "My Routines",
          child: Column(
            children: getWorkouts().map((workout) =>
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogScreen(workout: workout)),
                      );
                    },
                    child: Text(workout.name)
                )
            ).toList(),
          )
      ),
    );
  }
}
