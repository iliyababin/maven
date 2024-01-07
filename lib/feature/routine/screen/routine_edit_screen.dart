import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../exercise/model/exercise_list.dart';
import '../../exercise/widget/exercise_list_widget.dart';
import '../../note/note.dart';
import '../../theme/theme.dart';

typedef RoutineEditCallback = void Function(Routine routine, ExerciseList exerciseList);

class RoutineEditScreen extends StatefulWidget {
  const RoutineEditScreen({
    Key? key,
    this.routine,
    this.exerciseGroups,
    required this.onSubmit,
  }) : super(key: key);

  final Routine? routine;
  final List<ExerciseGroupDto>? exerciseGroups;
  final RoutineEditCallback onSubmit;

  @override
  State<RoutineEditScreen> createState() => _RoutineEditScreenState();
}

class _RoutineEditScreenState extends State<RoutineEditScreen> {
  late Routine routine;
  late ExerciseList exerciseList;

  @override
  void initState() {
    exerciseList = ExerciseList([]);
    if (widget.routine == null) {
      routine = Routine(
        name: '',
        note: '',
        timestamp: DateTime.now(),
        type: RoutineType.template,
      );
    } else {
      routine = widget.routine!.copyWith();
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
              if (routine.name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please fill in all fields',
                    ),
                  ),
                );
                return;
              }
              widget.onSubmit(routine, exerciseList);
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
            padding: EdgeInsets.all(
              T(context).space.large,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  NoteWidget(
                    note: routine.note,
                    onChanged: (value) {
                      setState(() {
                        routine = routine.copyWith(note: value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              if (state.status.isLoaded) {
                return ExerciseListWidget(
                  exercises: state.exercises,
                  exerciseList: exerciseList,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<Exercise>? exercises = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExerciseSelectionScreen(),
            ),
          );

          for (Exercise exercise in exercises ?? []) {
            setState(() {
              exerciseList.addExerciseGroup(exercise);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
