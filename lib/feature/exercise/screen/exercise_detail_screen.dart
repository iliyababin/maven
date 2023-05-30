import 'package:Maven/common/extension.dart';
import 'package:flutter/material.dart';

import '../../../database/model/model.dart';
import '../../../theme/widget/inherited_theme_widget.dart';

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
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.muscle.name.parseMuscleToString(),
              style: T(context).textStyle.subtitle1,
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
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.muscleGroup.name.capitalize(),
              style: T(context).textStyle.subtitle1,
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
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.equipment.name.capitalize(),
              style: T(context).textStyle.subtitle1,
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
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              exercise.exerciseType.name,
              style: T(context).textStyle.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
