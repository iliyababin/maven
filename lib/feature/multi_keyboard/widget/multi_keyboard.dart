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
          barId: widget.barId ?? 0,
          weight: double.parse(widget.data.value),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 220,
                  minWidth: 65,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      icon: Icon(
                        Icons.history_rounded,
                        color: _selectedTab == 0 ? null : T(context).color.onBackground,
                      ),
                    ),
                    if(Equipment.barbell == widget.equipment)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedTab = 1;
                          });
                        },
                        icon: Icon(
                          Icons.calculate_rounded,
                          color: _selectedTab == 1 ? null : T(context).color.onBackground,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 2;
                        });
                      },
                      icon: Icon(
                        Icons.numbers_rounded,
                        color: _selectedTab == 2 ? null : T(context).color.onBackground,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //widget.onValueChanged(_controller.text);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.check,
                        color: T(context).color.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
