import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/dialog/list_dialog.dart';
import 'package:maven/common/dialog/timer_picker_dialog.dart';
import 'package:maven/common/extension.dart';
import 'package:maven/feature/equipment/screen/bar_selection_screen.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/database.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';

class ExerciseGroupMenu extends StatelessWidget {
  const ExerciseGroupMenu({
    Key? key,
    required this.exercise,
    required this.exerciseGroup,
    required this.onExerciseGroupUpdate,
    required this.onExerciseGroupDelete,
  }) : super(key: key);

  final Exercise exercise;
  final ExerciseGroup exerciseGroup;
  final ValueChanged<ExerciseGroup> onExerciseGroupUpdate;
  final Function() onExerciseGroupDelete;

  @override
  Widget build(BuildContext context) {
    return ListDialog(
      children: [
        if (exercise.equipment == Equipment.barbell)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarSelectionScreen(),
                ),
              ).then((bar) {
                if (bar != null) {
                  onExerciseGroupUpdate(exerciseGroup.copyWith(barId: bar.id));
                }
              });
            },
            leading: const Icon(
              Icons.fitness_center_rounded,
            ),
            title: const Text(
              'Bar Type',
            ),
            trailing: BlocBuilder<EquipmentBloc, EquipmentState>(
              builder: (context, state) {
                if (state.status.isLoaded) {
                  Bar bar = state.bars.firstWhere((element) => element.id == exerciseGroup.barId);
                  return Text(
                    bar.name,
                  );
                } else {
                  return const Text('');
                }
              },
            ),
          ),
        if (exercise.weightUnit != null)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              showBottomSheetDialog(
                  context: context,
                  child: ListView.builder(
                    itemCount: WeightUnit.values.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      WeightUnit weightUnit = WeightUnit.values[index];
                      return MButton.tiled(
                          onPressed: () {
                            onExerciseGroupUpdate(exerciseGroup.copyWith(weightUnit: weightUnit));
                            Navigator.pop(context);
                          },
                          expand: false,
                          leading: exerciseGroup.weightUnit == weightUnit
                              ? Container(
                                  width: 20,
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(
                                    Icons.check,
                                  ),
                                )
                              : Container(
                                  width: 20,
                                ),
                          title: weightUnit.name);
                    },
                  ));
            },
            leading: const Icon(
              Icons.scale,
            ),
            title: const Text(
              'Weight Unit',
            ),
            trailing: Text(
              exerciseGroup.weightUnit?.name.toString() ?? '',
            ),
          ),
        if (exercise.distanceUnit != null)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              showBottomSheetDialog(
                  context: context,
                  child: ListView.builder(
                    itemCount: DistanceUnit.values.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DistanceUnit distanceUnit = DistanceUnit.values[index];
                      return MButton.tiled(
                          onPressed: () {
                            onExerciseGroupUpdate(exerciseGroup.copyWith(distanceUnit: distanceUnit));
                            Navigator.pop(context);
                          },
                          expand: false,
                          leading: exerciseGroup.distanceUnit == distanceUnit
                              ? Container(
                                  width: 20,
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(
                                    Icons.check,
                                  ),
                                )
                              : Container(
                                  width: 20,
                                ),
                          title: distanceUnit.name.capitalize());
                    },
                  ));
            },
            leading: const Icon(
              Icons.directions_run,
            ),
            title: const Text(
              'Distance Unit',
            ),
            trailing: Text(
              exerciseGroup.distanceUnit!.name.toString(),
            ),
          ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            showBottomSheetDialog(
              context: context,
              child: TimedPickerDialog(
                initialValue: exerciseGroup.timer,
                onSubmit: (value) {
                  onExerciseGroupUpdate(exerciseGroup.copyWith(timer: value));
                },
              ),
              onClose: () {},
            );
          },
          leading: const Icon(
            Icons.timer,
          ),
          title: const Text(
            'Auto Rest Timer',
          ),
          trailing: Text(
            exerciseGroup.timer.toString(),
          ),
        ),
        ListTile(
          onTap: () {
            onExerciseGroupDelete();
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.delete_rounded,
            color: T(context).color.error,
          ),
          title: Text(
            'Remove Exercise',
            style: TextStyle(
              color: T(context).color.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
