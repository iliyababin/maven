import 'package:Maven/common/dialog/timer_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../theme/m_themes.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';
import '../../equipment/model/bar.dart';
import '../model/exercise.dart';
import '../model/exercise_equipment.dart';
import '../model/exercise_group.dart';

class ExerciseGroupMenu extends StatelessWidget {
  const ExerciseGroupMenu({Key? key,
    required this.exercise,
    required this.exerciseGroup,
    required this.onExerciseGroupUpdate,
  }) : super(key: key);

  final Exercise exercise;
  final ExerciseGroup exerciseGroup;
  final ValueChanged<ExerciseGroup> onExerciseGroupUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        exercise.exerciseEquipment == ExerciseEquipment.barbell ? MButton.tiled(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              'Bar Type',
                              style: TextStyle(
                                color: mt(context).color.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
                                  child: Icon(
                                    Icons.check,
                                    color: mt(context).icon.accentColor,
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
          leading: Icon(
            Icons.fitness_center_rounded,
            color: mt(context).icon.accentColor,
            size: 24,
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
            color: mt(context).icon.accentColor,
            size: 24,
          ),
          trailing: Text(
            '(${exerciseGroup.restTimed.toString()})',
            style: mt(context).textStyle.subtitle1,
          ),
          title: 'Rest Timer',
        ),
        MButton.tiled(
          onPressed: (){},
          leading: Icon(
            Icons.delete_rounded,
            color: mt(context).icon.errorColor,
            size: 24,
          ),
          title: 'Remove',
        ),
      ],
    );
  }
}
