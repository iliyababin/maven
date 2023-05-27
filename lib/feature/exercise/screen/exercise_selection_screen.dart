import 'package:Maven/common/extension.dart';
import 'package:Maven/common/widget/m_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/model/exercise.dart';
import '../bloc/exercise_bloc.dart';
import 'exercise_detail_screen.dart';

/// Screen for selecting an [Exercise]
class ExerciseSelectionScreen extends StatefulWidget {
  /// Creates a screen for selecting an [Exercise]
  const ExerciseSelectionScreen({Key? key,
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

  final FocusNode _searchNode = FocusNode();
  
  final TextEditingController _searchTextEditingController = TextEditingController();

  bool typing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: typing ? TextField(
          focusNode: _searchNode,
          style: TextStyle(
            color: mt(context).color.text,
          ),
          controller: _searchTextEditingController,
          onSubmitted: (value) {
            if(value.isEmpty) {
              setState(() {
                typing = false;
                _searchNode.unfocus();
              });
            }
          },
          onChanged: (value) {
            setState(() {

            });
          },
          decoration: const InputDecoration(
            hintText: 'Search exercise',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ) : Text(
          !widget.selection ? 'Exercises' : _selectedExercises.isEmpty
              ? 'Select Exercise${widget.single ? '' : '(s)'}'
              : '${_selectedExercises.length} Exercise${_selectedExercises.length > 1 ? 's' : ''}',
        ),
        actions: [
          typing ? IconButton(
            onPressed: () {
              setState(() {
                typing = false;
                _searchTextEditingController.clear();
              });
            },
            icon: const Icon(
              Icons.close,
            )
          ) :IconButton(
            onPressed: (){
              setState(() {
                typing = true;
                _searchNode.requestFocus();
              });
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          Visibility(
            visible: _selectedExercises.isNotEmpty,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context, _selectedExercises);
              },
              icon: const Icon(
                Icons.check,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mt(context).padding.page,
              vertical: 16,
            ),
            child: Row(
              children: [
                MButton(
                  onPressed: () {},
                  height: 36,
                  borderColor: mt(context).color.secondary,
                  child: Text(
                    'Muscle',
                    style: mt(context).textStyle.body1,
                  ),
                ),
                const SizedBox(width: 10,),
                MButton(
                  onPressed: () {},
                  height: 36,
                  borderColor: mt(context).color.secondary,
                  child: Text(
                    'Group',
                    style: mt(context).textStyle.body1,
                  ),
                ),
                const SizedBox(width: 10,),
                MButton(
                  onPressed: () {},
                  height: 36,
                  borderColor: mt(context).color.secondary,
                  child: Text(
                    'Equipment',
                    style: mt(context).textStyle.body1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if(state.status == ExerciseStatus.loading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  List<Exercise> exercises = state.exercises;
                  if(_searchTextEditingController.text.isNotEmpty) {
                    exercises = exercises.where((exercise) => exercise.name.toLowerCase().contains(_searchTextEditingController.text.toLowerCase())).toList();
                  }

                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = exercises[index];
                      bool isSelected = _selectedExercises.contains(exercise);

                      return ListTile(
                        onTap: () {
                          if(widget.selection) {
                            setState(() {
                              if (!_selectedExercises.remove(exercise)) {
                                if(!widget.single || (widget.single && _selectedExercises.isEmpty)) {
                                  _selectedExercises.add(exercise);
                                }
                              }
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseDetailScreen(
                                  exercise: exercise,
                                )
                              ),
                            );
                          }
                        },
                        tileColor: isSelected ? mt(context).color.primary.withAlpha(30) : null,
                        leading: CircleAvatar(
                          child: Text(
                            exercise.name.substring(0, 1),
                          )
                        ),
                        title: Text(
                          exercise.name,
                          style: mt(context).textStyle.body1,
                        ),
                        subtitle: Text(
                          '${exercise.muscleGroup.name.capitalize()} · ${exercise.muscle.name.parseMuscleToString()}',
                          style: mt(context).textStyle.subtitle1,
                        ),
                        trailing: isSelected ? IconButton(
                          icon: Icon(
                            Icons.check,
                            color: mt(context).color.primary,
                          ),
                          onPressed: null,
                        ) : null,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
