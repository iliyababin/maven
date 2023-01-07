import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

Future<String?> showDialogWithTextField({
    required BuildContext context,
    required String title,
    required String hintText
  }) async {

  final formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: mt(context).dialog.backgroundColor,
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: mt(context).text.primaryColor
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mt(context).textField.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mt(context).textField.primaryOutlineColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mt(context).textField.errorOutlineColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mt(context).textField.errorOutlineColor),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: mt(context).textField.hintColor),
                        hintText: hintText,
                        fillColor: mt(context).backgroundColor,
                      ),
                      controller: textController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid input!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        // Validate the form and return the result.
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context, textController.text);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}