import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';
import '../../widget/m_flat_button.dart';

class TextInputDialog extends StatefulWidget {
  const TextInputDialog({Key? key,
    required this.title,
    this.hintText = '',
    required this.initialValue,
    this.keyboardType = TextInputType.number,
    required this.onValueChanged,
    this.onValueSubmit,
  }) : super(key: key);

  final String title;
  final String hintText;
  final String initialValue;
  final TextInputType keyboardType;
  final ValueChanged<String> onValueChanged;
  final ValueChanged<String>? onValueSubmit;

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: mt(context).text.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            onChanged: (value) => widget.onValueChanged(value),
            controller: _textEditingController,
            keyboardType: widget.keyboardType,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: mt(context).text.secondaryColor
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: mt(context).borderColor
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  width: 3,
                  style: BorderStyle.solid,
                  color: mt(context).accentColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          MFlatButton(
            onPressed: (){
              widget.onValueSubmit!(_textEditingController.text);
              Navigator.pop(context);
            },
            backgroundColor: mt(context).accentColor,
            borderRadius: 12,
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            text: Text(
              'Submit',
              style: TextStyle(
                  color: mt(context).text.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      ),
    );
  }
}
