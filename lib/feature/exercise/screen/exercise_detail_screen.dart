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
      body: const Center(
        child: Text('Exercise Detail'),
      ),
    );
  }
}
