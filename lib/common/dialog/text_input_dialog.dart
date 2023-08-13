import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';


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
            style: T(context).textStyle.titleLarge,
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
                if(widget.keyboardType == TextInputType.number) {
                  if(double.tryParse(value) == null) {
                    return "The input must be a number. ";
                  }
                }
                return null;
              },
              controller: _textEditingController,
              keyboardType: widget.keyboardType,
              style: T(context).textStyle.bodyLarge,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: T(context).textStyle.bodyMedium,
                errorStyle: TextStyle(
                  color: T(context).color.error,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: T(context).color.outline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: T(context).color.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: T(context).color.error,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.solid,
                    color: T(context).color.error,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: T(context).textStyle.labelMedium,
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: FilledButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      if(widget.onValueSubmit != null) {
                        widget.onValueSubmit!(_textEditingController.text);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: T(context).textStyle.labelLarge,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
