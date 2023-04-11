import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../common/widget/m_button.dart';
import '../../exercise/model/exercise_equipment.dart';
import 'barbell_calculator_widget.dart';
import 'numpad_widget.dart';

enum MKeyboardType {
  regular,
  barbell,
  distance,
  time,
}

class MKeyboard extends StatefulWidget {
  const MKeyboard({Key? key,
    this.barId,
    required this.exerciseEquipment,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  final int? barId;
  final ExerciseEquipment exerciseEquipment;
  final String value;
  final Function(String) onValueChanged;

  @override
  State<MKeyboard> createState() => _MKeyboardState();
}

class _MKeyboardState extends State<MKeyboard> {

  int _selectedTab = 2;

  late String values;

  @override
  void initState() {
    values = widget.value;
    super.initState();
  }

  Widget _buildScreen(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return Container();
      case 1:
        return BarbellCalculatorWidget(
          barId: widget.barId ?? 0,
          weight: values.isEmpty ? 0 : int.parse(values).toDouble(),
        );
      default:
        return NumPadWidget(
          value: values,
          onValueChanged: (value) {
            setState(() {
              values = value;
            });
            widget.onValueChanged(value);
          },
        );
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
            color: mt(context).color.secondary,
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
                    color: _selectedTab == 0 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
                  ),
                ),
                ExerciseEquipment.barbell == widget.exerciseEquipment ? MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  borderRadius: 0,
                  leading: Icon(
                    Icons.calculate_rounded,
                    color: _selectedTab == 1 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
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
                    color: _selectedTab == 2 ? mt(context).icon.accentColor : mt(context).icon.primaryColor,
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
                    color: mt(context).icon.completeColor,
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }


}