import 'package:Maven/common/dialog/timer_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/bar.dart';
import '../../../database/model/exercise.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';
import '../model/exercise_equipment.dart';
import '../model/exercise_group.dart';

class ExerciseGroupMenu extends StatelessWidget {
  const ExerciseGroupMenu({Key? key,
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
    return Column(
      children: [
        exercise.equipment == Equipment.barbell ? MButton.tiled(
          onPressed: (){
            Navigator.pop(context);
            showBottomSheetDialog(
              context: context,
              child: BlocBuilder<EquipmentBloc, EquipmentState>(
                builder: (context, state) {
                  if(state.status == EquipmentStatus.loading) {
                    return const Center(heightFactor: 3,child: CircularProgressIndicator());
                  } else {
                    List<Bar> bars = state.bars;
                    return SizedBox(
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: bars.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Bar bar = bars[index];
                              return MButton.tiled(
                                onPressed: (){
                                  onExerciseGroupUpdate(exerciseGroup.copyWith(barId: bar.barId));
                                  Navigator.pop(context);
                                },
                                leading: exerciseGroup.barId == bar.barId ? Container(
                                  width: 20,
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(
                                    Icons.check,
                                  ),
                                ) : Container(width: 20,),
                                title: bar.name,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              onClose: (){},
            );
          },
          leading: const Icon(
            Icons.fitness_center_rounded,
          ),
          title: 'Bar Type',
        ) : Container(),
        MButton.tiled(
          onPressed: (){
            Navigator.pop(context);
            showBottomSheetDialog(
              context: context,
              child: TimedPickerDialog(
                initialValue: exerciseGroup.restTimed,
                onSubmit: (value) {
                  onExerciseGroupUpdate(exerciseGroup.copyWith(restTimed: value));
                },
              ),
              onClose: (){}
            );
          },
          leading: Icon(
            Icons.timer,
          ),
          trailing: Text(
            '(${exerciseGroup.restTimed.toString()})',
            style: mt(context).textStyle.subtitle1,
          ),
          title: 'Rest Timer',
        ),
        MButton.tiled(
          onPressed: (){
            onExerciseGroupDelete();
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.delete_rounded,
            color: mt(context).color.error,
          ),
          title: 'Remove',
        ),
      ],
    );
  }
}
