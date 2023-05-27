import 'package:Maven/common/extension.dart';
import 'package:flutter/material.dart';

import '../../../database/model/model.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({Key? key,
    required this.exercise,
  }) : super(key: key);

  /// The [Exercise] to display
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.name,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {},
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.monitor_heart,
                ),
              ],
            ),
            title: Text(
              'Muscle',
              style: mt(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.muscle.name.parseMuscleToString(),
              style: mt(context).textStyle.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.health_and_safety,
                ),
              ],
            ),
            title: Text(
              'Group',
              style: mt(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.muscleGroup.name.capitalize(),
              style: mt(context).textStyle.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.category,
                ),
              ],
            ),
            title: Text(
              'Equipment',
              style: mt(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.equipment.name.capitalize(),
              style: mt(context).textStyle.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.tune,
                ),
              ],
            ),
            title: Text(
              'Type',
              style: mt(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.exerciseType.name,
              style: mt(context).textStyle.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
