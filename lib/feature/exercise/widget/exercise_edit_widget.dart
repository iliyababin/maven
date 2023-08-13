import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../../equipment/equipment.dart';
import '../../muscle/muscle.dart';
import '../exercise.dart';

class ExerciseEditWidget extends StatelessWidget {
  const ExerciseEditWidget({
    Key? key,
    required this.exercise,
    required this.onModify,
    this.typesEnabled = false,
  }) : super(key: key);

  final Exercise exercise;
  final ValueChanged<Exercise> onModify;
  final bool typesEnabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: T(context).color.surface,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MuscleSelectionScreen(
                      muscle: exercise.muscle,
                    ),
                  ),
                ).then(( value) {
                  if (value != null) {
                    onModify(exercise.copyWith(muscle: value));
                  }
                });
              },
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_heart,
                  ),
                ],
              ),
              title: Text(
                'Muscle',
                style: T(context).textStyle.bodyLarge,
              ),
              trailing: Text(
                exercise.muscle.name,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MuscleGroupSelectionScreen(
                      muscleGroup: exercise.muscleGroup,
                    ),
                  ),
                ).then((value) {
                  if (value != null) {
                    onModify(exercise.copyWith(muscleGroup: value));
                  }
                });
              },
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.health_and_safety,
                  ),
                ],
              ),
              title: Text(
                'Muscle Group',
                style: T(context).textStyle.bodyLarge,
              ),
              trailing: Text(
                exercise.muscleGroup.name.capitalize,
              ),
            ),
            ListTile(
              onTap: () {
                showBottomSheetDialog(
                  context: context,
                  child: TimedPickerDialog(
                    initialValue: exercise.timer,
                    onSubmit: (value) {
                      onModify(exercise.copyWith(timer: value));
                    },
                  ),
                );
              },
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer,
                  ),
                ],
              ),
              title: Text(
                'Timer',
                style: T(context).textStyle.bodyLarge,
              ),
              trailing: Text(
                exercise.timer.toString(),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipmentSelectionScreen(
                      equipment: exercise.equipment,
                    ),
                  ),
                ).then((value) {
                  if (value != null) {
                    onModify(exercise.copyWith(equipment: value));
                  }
                });
              },
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                  ),
                ],
              ),
              title: Text(
                'Equipment',
                style: T(context).textStyle.bodyLarge,
              ),
              trailing: Text(
                exercise.equipment.name.capitalize,
              ),
            ),
            ListTile(
              onTap: () {
                if(typesEnabled) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseTypeSelectionScreen(
                        exercise: exercise,
                        exerciseTypes: exercise.fields.map((e) => e.type).toList(),
                      ),
                    ),
                  ).then((value) {
                    if (value != null) {
                      onModify(value);
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Supported only when creating exercise'),
                  ));
                }
              },
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tune,
                  ),
                ],
              ),
              title: Text(
                'Type',
                style: T(context).textStyle.bodyLarge,
              ),
              trailing: Text(
                exercise.fields.isEmpty ? 'None' :
                exercise.fields.map((obj) => obj.type.name.capitalize).join(' | '),
              ),
            ),
            if (exercise.weightUnit != null)
              ListTile(
                onTap: () {
                  showBottomSheetDialog(
                    context: context,
                    child: ListDialog(
                      children: List.generate(
                        WeightUnit.values.length,
                        (index) {
                          return ListTile(
                            onTap: () {
                              onModify(exercise.copyWith(weightUnit: WeightUnit.values[index]));
                              Navigator.pop(context);
                            },
                            title: Text(
                              WeightUnit.values[index].name,
                            ),
                            trailing: exercise.weightUnit == WeightUnit.values[index]
                                ? const Icon(
                                    Icons.check_outlined,
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.scale,
                ),
                title: Text(
                  'Weight Unit',
                  style: T(context).textStyle.bodyLarge,
                ),
                trailing: Text(
                  exercise.weightUnit!.name.toString().capitalize,
                ),
              ),
            if (exercise.distanceUnit != null)
              ListTile(
                onTap: () {
                  showBottomSheetDialog(
                    context: context,
                    child: ListDialog(
                      children: List.generate(
                        DistanceUnit.values.length,
                        (index) {
                          return ListTile(
                            onTap: () {
                              onModify(exercise.copyWith(distanceUnit: DistanceUnit.values[index]));
                              Navigator.pop(context);
                            },
                            title: Text(
                              DistanceUnit.values[index].name,
                            ),
                            trailing: exercise.distanceUnit == DistanceUnit.values[index]
                                ? const Icon(
                                    Icons.check_outlined,
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.directions_run,
                ),
                title: Text(
                  'Distance Unit',
                  style: T(context).textStyle.bodyLarge,
                ),
                trailing: Text(
                  exercise.distanceUnit!.name.toString().capitalize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
