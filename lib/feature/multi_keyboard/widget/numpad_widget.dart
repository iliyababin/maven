import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../theme/theme.dart';

class NumPadWidget extends StatefulWidget {
  const NumPadWidget({
    Key? key,
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
    if (widget.value == 0) {
      _controller.text = '';
    } else {
      _controller.text = widget.value.truncateZeros;
    }
    super.initState();

    _controller.addListener(() {
      widget.onValueChanged(
          double.parse(_controller.text.isEmpty ? '0' : _controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget numberTile(String number) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          int selectionStart = _controller.selection.start;
          int selectionEnd = _controller.selection.end;

          String currentText = _controller.text;
          String newText = currentText.substring(0, selectionStart) +
              number.toString() +
              currentText.substring(selectionEnd);

          // Check if the new text contains more than one dot
          if (newText.split('.').length > 2) {
            return; // Ignore the button press if there are multiple dots
          }

          _controller.text = newText;
          _controller.selection = TextSelection.collapsed(
              offset: selectionStart + 1, affinity: TextAffinity.upstream);
        },
        child: Text(
          number,
          style: T(context).textStyle.titleLarge.copyWith(
            color: T(context).color.onBackground,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 20, top: 12, bottom: 6),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.none,
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: T(context).textStyle.titleLarge,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: T(context).textStyle.titleLarge,
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              numberTile('1'),
              numberTile('2'),
              numberTile('3'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              numberTile('4'),
              numberTile('5'),
              numberTile('6'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              numberTile('7'),
              numberTile('8'),
              numberTile('9'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              numberTile('.'),
              numberTile('0'),
              MButton(
                onPressed: () {
                  int selectionStart = _controller.selection.start;
                  int selectionEnd = _controller.selection.end;

                  if (selectionStart == 0 && selectionEnd == 0) return;

                  if (selectionStart == selectionEnd) {
                    selectionStart = selectionStart - 1;
                  }

                  _controller.text =
                      _controller.text.substring(0, selectionStart) +
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
      ],
    );
  }
}
