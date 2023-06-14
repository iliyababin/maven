import 'package:flutter/material.dart';

import '../../../common/widget/m_button.dart';
import '../../../database/TEST_ZONE/exercise_group.dart';
import '../../../database/model/exercise_field.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../exercise/model/exercise_equipment.dart';
import 'barbell_calculator_widget.dart';
import 'numpad_widget.dart';

enum MKeyboardType {
  regular,
  barbell,
  distance,
  time,
}

class MultiKeyboard extends StatefulWidget {
  const MultiKeyboard({Key? key,
    this.barId,
    required this.equipment,
    required this.option,
    required this.onValueChanged,
  }) : super(key: key);

  final int? barId;
  final Equipment equipment;
  final ExerciseSetOption option;
  final Function(ExerciseSetOption) onValueChanged;

  @override
  State<MultiKeyboard> createState() => _MultiKeyboardState();
}

class _MultiKeyboardState extends State<MultiKeyboard> {
  int _selectedTab = 2;

  Widget _buildScreen(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return Container();
      case 1:
        return BarbellCalculatorWidget(
          barId: widget.barId ?? 0,
          weight: double.parse(widget.option.value),
        );
      default:
        switch (widget.option.type) {
          case ExerciseFieldType.weight:
            return NumPadWidget(
              value: double.parse(widget.option.value),
              onValueChanged: (value) {
                widget.option.set(value);
                widget.onValueChanged(widget.option);
              },
            );
          default:
            return Container();
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(height: double.infinity, child: _buildScreen(_selectedTab)),
          ),
          Container(
            width: 1,
            color: T(context).color.secondary,
          ),
          SizedBox(
            width: 70,
            child: Column(
              children: [
                MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  borderRadius: 0,
                  leading: Icon(
                    Icons.history_rounded,
                    color: _selectedTab == 0 ? null : T(context).color.text,
                  ),
                ),
                Equipment.barbell == widget.equipment ? MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  borderRadius: 0,
                  leading: Icon(
                    Icons.calculate_rounded,
                    color: _selectedTab == 1 ? null : T(context).color.text,
                  ),
                ) : Container(),
                MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 2;
                    });
                  },
                  borderRadius: 0,
                  leading: Icon(
                    Icons.numbers_rounded,
                    color: _selectedTab == 2 ? null : T(context).color.text,
                  ),
                ),
                MButton(
                  onPressed: (){
                    //widget.onValueChanged(_controller.text);
                    Navigator.pop(context);
                  },
                  borderRadius: 0,
                  leading: Icon(
                    Icons.check,
                    color: T(context).color.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}