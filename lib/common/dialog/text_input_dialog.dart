import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';
import '../../widget/m_flat_button.dart';

class TextInputDialog extends StatelessWidget {
  const TextInputDialog({Key? key,
    required this.title,
    required this.initialValue,
    this.keyboardType = TextInputType.number,
    required this.onValueChanged,
  }) : super(key: key);

  final String title;
  final String initialValue;
  final TextInputType keyboardType;
  final ValueChanged<String> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: mt(context).text.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            onChanged: (value) => onValueChanged(value),
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
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
                    color: mt(context).accentColor
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          MFlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            backgroundColor: mt(context).accentColor,
            borderRadius: 12,
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
