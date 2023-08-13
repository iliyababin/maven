import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';

class ExerciseTypeSelectionScreen extends StatefulWidget {
  const ExerciseTypeSelectionScreen({
    Key? key,
    required this.exercise,
    this.exerciseTypes,
  }) : super(key: key);

  final Exercise exercise;
  final List<ExerciseFieldType>? exerciseTypes;

  @override
  State<ExerciseTypeSelectionScreen> createState() => _ExerciseTypeSelectionScreenState();
}

class _ExerciseTypeSelectionScreenState extends State<ExerciseTypeSelectionScreen> {
  late Exercise exercise;
  late final List<ExerciseFieldType> exerciseTypes;

  @override
  void initState() {
    exercise = widget.exercise.copyWith();
    exerciseTypes = List.from(widget.exerciseTypes ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchableSelectionScreen<ExerciseFieldType>(
      title: 'Types',
      items: ExerciseFieldType.values,
      actions: [
        IconButton(
          onPressed: () {
            if (exerciseTypes.length < 1 || exerciseTypes.length > 3) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'You must select between 1 and 3 types.',
                  ),
                ),
              );
              return;
            }
            Navigator.pop(
              context,
              exercise.copyWith(
                fields: exerciseTypes.map((e) {
                  return ExerciseField(
                    exerciseId: -1,
                    type: e,
                  );
                }).toList(),
              ),
            );
          },
          icon: Icon(
            Icons.check,
            color: exerciseTypes.length < 1 || exerciseTypes.length > 3 ? T(context).color.outlineVariant : null,
          ),
        ),
      ],
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          onTap: () {
            setState(() {
              if (exerciseTypes.remove(item)) {
                exercise = Exercise(
                  id: exercise.id,
                  name: exercise.name,
                  muscle: exercise.muscle,
                  muscleGroup: exercise.muscleGroup,
                  timer: exercise.timer,
                  equipment: exercise.equipment,
                  videoPath: exercise.videoPath,
                  weightUnit: item == ExerciseFieldType.weight ? null : exercise.weightUnit,
                  distanceUnit: item == ExerciseFieldType.distance ? null : exercise.distanceUnit,
                  barId: exercise.barId,
                );
              } else {
                exercise = exercise.copyWith(
                  weightUnit: item == ExerciseFieldType.weight ? WeightUnit.kilogram : null,
                  distanceUnit: item == ExerciseFieldType.distance ? DistanceUnit.meter : null,
                );
                exerciseTypes.add(item);
              }
            });
          },
          leading: CircleAvatar(
            child: Text(
              item.name[0],
            ),
          ),
          title: Text(item.name),
          tileColor: exerciseTypes.contains(item) ? T(context).color.primaryContainer : null,
          trailing: exerciseTypes.contains(item) ? const Icon(Icons.check) : null,
        );
      },
    );
  }
}
