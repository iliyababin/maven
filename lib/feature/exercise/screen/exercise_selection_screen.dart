import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../exercise.dart';

/// Screen for selecting an [Exercise]
class ExerciseSelectionScreen extends StatefulWidget {
  /// Creates a screen for selecting an [Exercise]
  const ExerciseSelectionScreen({
    Key? key,
    this.single = false,
    this.selection = true,
  }) : super(key: key);

  /// Whether to select a single exercise or multiple exercises
  final bool single;

  /// Whether to select exercises or just view them
  final bool selection;

  @override
  State<ExerciseSelectionScreen> createState() => _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  final List<Exercise> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state.status == ExerciseStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state.status == ExerciseStatus.loaded) {
          return SearchableSelectionScreen(
            title: 'Exercises',
            items: state.exercises,
            actions: [
              IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.add_outlined,
                ),
              ),
              if (widget.selection)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedExercises);
                  },
                  icon: const Icon(
                    Icons.check_outlined,
                  ),
                ),
            ],
            itemBuilder: (BuildContext context, Exercise item) {
              return ListTile(
                onTap: () {
                  if (widget.selection) {
                    setState(() {
                      if (!_selectedExercises.remove(item)) {
                        if (!widget.single || (widget.single && _selectedExercises.isEmpty)) {
                          _selectedExercises.add(item);
                        }
                      }
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExerciseDetailScreen(exercise: item)),
                    );
                  }
                },
                leading: CircleAvatar(
                  child: Text(
                    item.name.substring(0, 1).toUpperCase(),
                  ),
                ),
                tileColor: widget.selection && _selectedExercises.contains(item) ? T(context).color.primaryContainer : null,
                title: Text(
                  item.name,
                ),
                subtitle: Text(
                  '${item.muscleGroup.name.capitalize} · ${item.muscle.name}',
                ),
                trailing: widget.selection
                    ? Icon(
                        _selectedExercises.contains(item) ? Icons.check : null,
                      )
                    : null,
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              'Something went wrong',
            ),
          );
        }
      },
    );
  }
}
