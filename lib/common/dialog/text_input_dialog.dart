import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';
import '../widget/m_button.dart';

/// Dialog that prompts the user to enter some text.
///
/// To be used with [showBottomSheetDialog].
class TextInputDialog extends StatefulWidget {
  /// Creates a text input dialog
  const TextInputDialog({Key? key,
    required this.title,
    this.hintText = '',
    required this.initialValue,
    this.keyboardType = TextInputType.number,
    this.onValueChanged,
    this.onValueSubmit,
  }) : super(key: key);

  /// The bold text displayed at the top of the dialog.
  final String title;

  /// The text which is filled in the [TextFormField] at the start.
  final String hintText;
  final String initialValue;
  final TextInputType keyboardType;
  final ValueChanged<String>? onValueChanged;
  final ValueChanged<String>? onValueSubmit;

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  late TextEditingController _textEditingController;

  final _formKey = GlobalKey<FormState>();

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
            style: mt(context).textStyle.heading3,
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: TextFormField(
              onChanged: (value) {
                if(widget.onValueChanged == null) return;
                if(value.isEmpty) value = 0.toString();
                widget.onValueChanged!(value);
              },
              validator: (value) {
                if(value == null || value.isEmpty) return "The input cannot be empty. ";
                return null;
              },
              controller: _textEditingController,
              keyboardType: widget.keyboardType,
              style: mt(context).textStyle.body1,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: mt(context).textStyle.subtitle1,
                errorStyle: TextStyle(
                  color: mt(context).color.error,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: mt(context).color.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: mt(context).color.primary,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: mt(context).color.error,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              MButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                backgroundColor: mt(context).color.background,
                borderColor: mt(context).color.secondary,
                child: Text(
                  'Cancel',
                  style: mt(context).textStyle.button2,
                ),
              ),
              const SizedBox(width: 15,),
              MButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    if(widget.onValueSubmit != null) {
                      widget.onValueSubmit!(_textEditingController.text);
                    }
                    Navigator.pop(context);
                  }
                },
                backgroundColor: mt(context).color.primary,
                child: Text(
                  'Submit',
                  style: mt(context).textStyle.button1,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
