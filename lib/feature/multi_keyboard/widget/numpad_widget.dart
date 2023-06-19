import 'package:flutter/material.dart';
import 'package:maven/common/util/general_utils.dart';

import '../../../common/widget/m_button.dart';
import '../../../theme/widget/inherited_theme_widget.dart';

class NumPadWidget extends StatefulWidget {
  const NumPadWidget({Key? key,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  final double value;
  final Function(double) onValueChanged;

  @override
  State<NumPadWidget> createState() => _NumPadWidgetState();
}

class _NumPadWidgetState extends State<NumPadWidget> {

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    if(widget.value == 0) {
      _controller.text = '';
    } else {
      _controller.text = removeDecimalZeroFormat(widget.value);
    }
    super.initState();

    _controller.addListener(() {
      widget.onValueChanged(double.parse(_controller.text.isEmpty ? '0'  : _controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  MButton numberTile(String number) {
    return MButton(
      onPressed: (){
        int selectionStart = _controller.selection.start;
        int selectionEnd = _controller.selection.end;

        _controller.text = _controller.text.substring(0, selectionStart) +
            number.toString() +
            _controller.text.substring(selectionEnd);
        _controller.selection =
            TextSelection.collapsed(offset: selectionStart + 1, affinity: TextAffinity.upstream);
      },
      height: double.infinity,
      borderRadius: 0,
      child: Text(
        number.toString(),
        style: T(context).textStyle.heading3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20, top: 12, bottom: 6),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.none,
            decoration: InputDecoration(
              hintText: '',
              hintStyle: T(context).textStyle.subtitle1,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: T(context).textStyle.body1,
          ),
        ),

        Container(
          height: 2,
          color: T(context).color.secondary,
        ),

        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                    children: [
                      numberTile('1'),
                      numberTile('2'),
                      numberTile('3'),
                    ]
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    numberTile('4'),
                    numberTile('5'),
                    numberTile('6'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    numberTile('7'),
                    numberTile('8'),
                    numberTile('9'),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 65,
                  child: Row(
                    children: [
                      numberTile('.'),
                      numberTile('0'),

                      MButton(
                        onPressed: (){
                          int selectionStart = _controller.selection.start;
                          int selectionEnd = _controller.selection.end;

                          if(selectionStart == 0 && selectionEnd == 0) return;

                          if (selectionStart == selectionEnd) {
                            selectionStart = selectionStart - 1;
                          }

                          _controller.text = _controller.text.substring(0, selectionStart) +
                              _controller.text.substring(selectionEnd);
                          _controller.selection =
                              TextSelection.collapsed(offset: selectionStart);
                        },
                        height: 65,
                        borderRadius: 0,
                        leading: Icon(
                          Icons.backspace_rounded,
                          color: T(context).color.onBackground,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
