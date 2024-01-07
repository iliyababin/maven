import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/model/exercise_set_data_dto.dart';
import '../../theme/theme.dart';
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
  final ExerciseSetDataDto data;
  final Function(ExerciseSetDataDto) onValueChanged;

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
              if (newValue < 0) return;
              widget.data.value = newValue.toString();

              widget.onValueChanged(widget.data);
              setState(() {});
            } catch (e) {}
          },
        );
      default:
        switch (widget.data.fieldType) {
          case ExerciseFieldType.reps:
            return NumPadWidget(
              value: double.parse(
                  widget.data.value.isEmpty ? '0' : widget.data.value),
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
              value: double.parse(
                  widget.data.value.isEmpty ? '0' : widget.data.value),
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
              initialValue: Timed.fromSeconds(int.parse(
                  widget.data.value.isEmpty ? '0' : widget.data.value)),
              onSubmit: (value) {
                widget.data.value = value.toSeconds().toString();
                widget.onValueChanged(widget.data);
              },
            );
          default:
            return NumPadWidget(
              value: double.parse(
                  widget.data.value.isEmpty ? '0' : widget.data.value),
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
    return SizedBox(
      height: 320,
      child: Row(
        children: [
          Expanded(
            child: _buildScreen(_selectedTab),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Material(
                  color: T(context).color.background,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                    child: SizedBox(
                      width: 80,
                      child: Icon(
                        Icons.history_rounded,
                        color: _selectedTab == 0
                            ? null
                            : T(context).color.onBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              if (Equipment.barbell == widget.equipment &&
                  widget.data.requiresBar)
              Expanded(
                child: Material(
                  color: T(context).color.background,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    child: SizedBox(
                      width: 80,
                      child: Icon(
                        Icons.calculate_outlined,
                        color: _selectedTab == 1
                            ? null
                            : T(context).color.onBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: T(context).color.background,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        _selectedTab = 2;
                      });
                    },
                    child: SizedBox(
                      width: 80,
                      child: Icon(
                        Icons.numbers_rounded,
                        color: _selectedTab == 2
                            ? null
                            : T(context).color.onBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: T(context).color.background,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 80,
                      child: Icon(
                        Icons.keyboard_hide_outlined,
                        color: T(context).color.onBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
