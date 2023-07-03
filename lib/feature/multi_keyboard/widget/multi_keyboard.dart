import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../exercise/model/exercise_set_data.dart';
import '../multi_keyboard.dart';


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
    required this.data,
    required this.onValueChanged,
  }) : super(key: key);

  final int? barId;
  final Equipment equipment;
  final ExerciseSetData data;
  final Function(ExerciseSetData) onValueChanged;

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
          weight: double.parse(widget.data.value),
        );
      default:
        switch (widget.data.fieldType) {
          case ExerciseFieldType.reps:
            return NumPadWidget(
              value: double.parse(widget.data.value.isEmpty ? '0' : widget.data.value),
              onValueChanged: (value) {
                if(value == 0) {
                  widget.data.value = '';
                } else {
                  widget.data.value = value.toStringAsFixed(0);
                }
                widget.onValueChanged(widget.data);
              },
            );
          case ExerciseFieldType.distance:
            return NumPadWidget(
              value: double.parse(widget.data.value.isEmpty ? '0' : widget.data.value),
              onValueChanged: (value) {
                if(value == 0) {
                  widget.data.value = '';
                } else {
                  widget.data.value = value.toString();
                }
                widget.onValueChanged(widget.data);
              },
            );
          default:
            return NumPadWidget(
              value: double.parse(widget.data.value.isEmpty ? '0' : widget.data.value),
              onValueChanged: (value) {
                if(value == 0) {
                  widget.data.value = '';
                } else {
                  widget.data.value = value.toString();
                }
                widget.onValueChanged(widget.data);
              },
            );
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
            color: T(context).color.outline,
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
                    color: _selectedTab == 0 ? null : T(context).color.onBackground,
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
                    color: _selectedTab == 1 ? null : T(context).color.onBackground,
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
                    color: _selectedTab == 2 ? null : T(context).color.onBackground,
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
                    color: T(context).color.onBackground,
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