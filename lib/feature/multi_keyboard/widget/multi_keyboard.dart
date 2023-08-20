import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../../exercise/model/exercise_set_data.dart';
import '../multi_keyboard.dart';

enum MKeyboardType {
  regular,
  barbell,
  distance,
  time,
}

class MultiKeyboard extends StatefulWidget {
  const MultiKeyboard({
    Key? key,
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
          barId: widget.barId,
          target: widget.data.value,
          onWeightChanged: (value) {
            try {
              double original = double.parse(widget.data.value);
              double newValue = original + value;
              if(newValue < 0) return;
              widget.data.value = newValue.toString();

              widget.onValueChanged(widget.data);
              setState(() {

              });
            } catch (e) {
            }
          },
        );
      default:
        switch (widget.data.fieldType) {
          case ExerciseFieldType.reps:
            return NumPadWidget(
              value: double.parse(widget.data.value.isEmpty ? '0' : widget.data.value),
              onValueChanged: (value) {
                if (value == 0) {
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
                if (value == 0) {
                  widget.data.value = '';
                } else {
                  widget.data.value = value.toString();
                }
                widget.onValueChanged(widget.data);
              },
            );
          case ExerciseFieldType.duration:
            return TimedPickerDialog(
              initialValue: Timed.fromSeconds(int.parse(widget.data.value.isEmpty ? '0' : widget.data.value)),
              onSubmit: (value) {
                widget.data.value = value.toSeconds().toString();
                widget.onValueChanged(widget.data);
              },
            );
          default:
            return NumPadWidget(
              value: double.parse(widget.data.value.isEmpty ? '0' : widget.data.value),
              onValueChanged: (value) {
                if (value == 0) {
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildScreen(_selectedTab),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  width: 80,
                  height: 65,
                  child: Icon(
                    Icons.history_rounded,
                    color: _selectedTab == 0 ? null : T(context).color.onBackground,
                    size: 30,
                  ),
                ),
                if(Equipment.barbell == widget.equipment && widget.data.requiresBar)
                  MButton(
                    onPressed: (){
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    width: 80,
                    height: 65,
                    child: Icon(
                      Icons.calculate_rounded,
                      color: _selectedTab == 1 ? null : T(context).color.onBackground,
                      size: 30,
                    ),
                  ),
                MButton(
                  onPressed: (){
                    setState(() {
                      _selectedTab = 2;
                    });
                  },
                  width: 80,
                  height: 65,
                  child: Icon(
                    Icons.numbers_rounded,
                    color: _selectedTab == 2 ? null : T(context).color.onBackground,
                    size: 30,
                  ),
                ),
                MButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  width: 80,
                  height: 65,
                  child: Icon(
                    Icons.keyboard_hide_outlined,
                    color: T(context).color.onBackground,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
