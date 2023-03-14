import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/m_themes.dart';
import '../../../common/widget/m_button.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';
import '../../equipment/model/bar.dart';
import '../../template/dto/exercise_block.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../dto/exercise_set.dart';
import '../model/exercise.dart';
import '../model/exercise_equipment.dart';
import 'exercise_set_widget.dart';

class ExerciseGroupWidget extends StatefulWidget {
  const ExerciseGroupWidget({super.key,
    required this.exercise,
    required this.exerciseGroup,
    required this.exerciseSets,
    required this.onExerciseGroupUpdate,
    required this.onExerciseSetAdd,
    required this.onExerciseSetUpdate,
    required this.onExerciseSetDelete,
    this.checkboxEnabled = false,
    this.hintsEnabled = false,
  });

  final Exercise exercise;
  final ExerciseGroup exerciseGroup;
  final List<ExerciseSet> exerciseSets;
  final ValueChanged<ExerciseGroup> onExerciseGroupUpdate;
  final VoidCallback onExerciseSetAdd;
  final ValueChanged<ExerciseSet> onExerciseSetUpdate;
  final ValueChanged<ExerciseSet> onExerciseSetDelete;
  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseGroupWidget> createState() => _ExerciseGroupWidgetState();
}

class _ExerciseGroupWidgetState extends State<ExerciseGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SizedBox(width: 8),
            MButton(
              onPressed: (){},
              width: 40,
              height: 40,
              leading: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 26,
                color: mt(context).icon.accentColor,
              ),
            ),
            MButton(
              onPressed: () {

              },
              splashColor: mt(context).accentColor.withAlpha(50),
              mainAxisAlignment: MainAxisAlignment.start,
              height: 40,
              leading: SizedBox(width: 6),
              child: Text(
                widget.exercise.name,
                style: TextStyle(
                  fontSize: 18,
                  color: mt(context).text.accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            MButton(
              onPressed: (){
                showBottomSheetDialog(
                  context: context,
                  child: Column(
                    children: [
                      widget.exercise.exerciseEquipment == ExerciseEquipment.barbell ? MButton.tiled(
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
                                              print(widget.exerciseGroup.barId);

                                              return MButton.tiled(
                                                onPressed: (){
                                                  widget.onExerciseGroupUpdate(widget.exerciseGroup.copyWith(
                                                    barId: bar.barId,
                                                  ));
                                                  Navigator.pop(context);
                                                },
                                                leading: widget.exerciseGroup.barId == bar.barId ? Container(
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
                  ),
                  onClose: (){}
                );
              },
              width: 45,
              height: 40,
              child: Icon(
                Icons.more_horiz_rounded,
                color: mt(context).icon.accentColor,
              ),
            )
          ],
        ),

        ActiveExerciseRow.build(
            set: Text(
              "SET",
              style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
              ),
            ),
            previous: Text(
              "PREVIOUS",
              style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
              ),
            ),
            option1: Text(
              widget.exercise.exerciseType.exerciseTypeOption1.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).text.primaryColor,
              ),
            ),
            option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? Text(
              widget.exercise.exerciseType.exerciseTypeOption2!.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).text.primaryColor,
              ),
            ) : null,
            checkbox: widget.checkboxEnabled ? Container( alignment: Alignment.center, child: Text(''),) : null
        ),

        const SizedBox(height: 3),

        ListView.builder(
          itemCount: widget.exerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => widget.onExerciseSetDelete(widget.exerciseSets[index]),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
              ),
              child: ExerciseSetWidget(
                index: index + 1,
                barId: widget.exerciseGroup.barId,
                exercise: widget.exercise,
                exerciseSet: widget.exerciseSets[index],
                onExerciseSetUpdate: (value) => widget.onExerciseSetUpdate(value),
                checkboxEnabled: widget.checkboxEnabled,
                hintsEnabled: widget.hintsEnabled,
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: MButton(
            onPressed: () => widget.onExerciseSetAdd(),
            expand: false,
            leading: Icon(
              Icons.add_rounded,
              size: 24,
              color: mt(context).icon.accentColor,
            ),
            child: Text(
              'Add Set',
              style: TextStyle(
                color: mt(context).text.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

      ],
    );
  }

}
