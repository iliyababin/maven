import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../theme/m_themes.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';
import '../../equipment/model/bar.dart';
import '../model/exercise_equipment.dart';

class ExerciseGroupMenu extends StatelessWidget {
  const ExerciseGroupMenu({Key? key,
    required this.exerciseEquipment,
    required this.barId,
    required this.onBarChanged,
  }) : super(key: key);

  final ExerciseEquipment exerciseEquipment;
  final int? barId;
  final ValueChanged<int> onBarChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        exerciseEquipment == ExerciseEquipment.barbell ? MButton.tiled(
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
                      height: 300,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              'Bar Type',
                              style: TextStyle(
                                color: mt(context).text.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: bars.length,
                              itemBuilder: (context, index) {
                                Bar bar = bars[index];
                                return MButton.tiled(
                                  onPressed: (){
                                    onBarChanged(bar.barId!);
                                    Navigator.pop(context);
                                  },
                                  leading: barId == bar.barId ? Container(
                                    width: 20,
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.check,
                                      color: mt(context).icon.accentColor,
                                    ),
                                  ) : Container(width: 20,),
                                  child: Text(
                                    bar.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: mt(context).text.primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
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
          child: Text(
            'Bar Type',
            style: TextStyle(
              color: mt(context).text.primaryColor,
              fontSize: 17,
            ),
          ),
        ) : Container(),
        MButton.tiled(
            onPressed: (){},
            leading: Icon(
              Icons.delete_rounded,
              color: mt(context).icon.errorColor,
              size: 24,
            ),
            child: Text(
              'Remove',
              style: TextStyle(
                color: mt(context).text.errorColor,
                fontSize: 17,
              ),
            )
        ),
      ],
    );
  }
}
