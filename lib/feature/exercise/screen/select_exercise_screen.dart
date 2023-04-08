import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exercise_bloc.dart';
import '../model/exercise.dart';

class SelectExerciseScreen extends StatelessWidget {
  const SelectExerciseScreen({Key? key,
    this.exercises,
  }) : super(key: key);

  final List<Exercise>? exercises;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Exercise',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
      ),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if(state.status == ExerciseStatus.loading) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            List<Exercise> exercises = this.exercises ?? state.exercises;

            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = exercises[index];

                return ListTile(
                  onTap: () => Navigator.pop(context, exercise),
                  title: Text(
                    exercise.name,
                    style: TextStyle(
                        color: mt(context).text.primaryColor
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
