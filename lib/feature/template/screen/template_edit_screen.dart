import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/exercise.dart';

typedef TemplateEditCallback = void Function(Routine routine, List<ExerciseGroup> exerciseGroups);

class EditTemplateScreen extends StatefulWidget {
  const EditTemplateScreen({
    Key? key,
    this.routine,
    this.exerciseGroups,
    required this.onSubmit,
  }) : super(key: key);

  final Routine? routine;
  final List<ExerciseGroup>? exerciseGroups;
  final TemplateEditCallback onSubmit;

  @override
  State<EditTemplateScreen> createState() => _EditTemplateScreenState();
}

class _EditTemplateScreenState extends State<EditTemplateScreen> {
  late Routine routine;
  late List<ExerciseGroup> exerciseGroups;

  @override
  void initState() {
    if(widget.routine == null) {
      routine = Routine(
        name: '',
        note: '',
        sort: -1,
        timestamp: DateTime.now(),
        type: RoutineType.template,
      );
      exerciseGroups = [];
    } else {
      routine = widget.routine!.copyWith();
      exerciseGroups = widget.exerciseGroups!.map((exerciseGroup) {
        return exerciseGroup.copyWith(sets: exerciseGroup.sets.map((exerciseSet) {
          return exerciseSet.copyWith(
            data: exerciseSet.data.map((exerciseSetData) {
              return exerciseSetData.copyWith();
            }).toList(),
          );
        }).toList());
      }).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseGroups == null ? 'Create' : 'Edit',
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (routine.name.isEmpty || routine.note.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please fill in all fields',
                    ),
                  ),
                );
                return;
              }
              widget.onSubmit(routine, exerciseGroups);
            },
            icon: const Icon(
              Icons.check_rounded,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: T(context).space.large,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                 TextFormField(
                  onChanged: (value) {
                    routine = routine.copyWith(name: value);
                  },
                  initialValue: routine.name,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'New Template',
                    counterText: '',
                  ),
                  style: T(context).textStyle.headingLarge,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  onChanged: (value) {
                    routine = routine.copyWith(note: value);
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  initialValue: routine.note,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Notes',
                  ),
                  style: T(context).textStyle.bodyMedium,
                ),
                SizedBox(
                  height: T(context).space.large,
                ),
              ]),
            ),
          ),
          BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              if (state.status.isLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: exerciseGroups.length,
                        (context, index) {
                      ExerciseGroup exerciseGroup = exerciseGroups[index];
                      return ExerciseGroupWidget(
                        key: UniqueKey(),
                        exercise: state.exercises.firstWhere((exercise) => exercise.id == exerciseGroup.exerciseId),
                        exerciseGroup: exerciseGroup,
                        exerciseSets: exerciseGroup.sets,
                        onExerciseGroupUpdate: (value) {
                          setState(() {
                            exerciseGroups[index] = value;
                          });
                        },
                        onExerciseGroupDelete: () {
                          setState(() {
                            exerciseGroups.removeAt(index);
                          });
                        },
                        onExerciseSetAdd: (value) {
                          setState(() {
                            exerciseGroups[index].sets.add(value);
                          });
                        },
                        onExerciseSetUpdate: (value, setIndex) {
                          setState(() {
                            exerciseGroups[index].sets[setIndex] = value;
                          });
                        },
                        onExerciseSetDelete: (value) {
                          setState(() {
                            exerciseGroups[index].sets.removeWhere((exerciseSet) => exerciseSet.id == value.id);
                          });
                        },
                      );
                    },
                  ),
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onPressed: () async {
            List<Exercise>? exercises = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen()));

            for (Exercise exercise in exercises ?? []) {
              setState(() {
                exerciseGroups.add(ExerciseGroup(
                  timer: exercise.timer,
                  weightUnit: exercise.weightUnit,
                  distanceUnit: exercise.distanceUnit,
                  exerciseId: exercise.id!,
                  routineId: -1,
                  sets: [
                    ExerciseSet(
                      exerciseGroupId: -1,
                      checked: false,
                      type: ExerciseSetType.regular,
                      data: exercise.fields.map((e) {
                        return ExerciseSetData(
                          value: '',
                          fieldType: e.type,
                          exerciseSetId: -1,
                        );
                      }).toList(),
                    ),
                  ],
                  barId: exercise.barId,
                ));
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
