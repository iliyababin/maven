import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';
import '../widget/m_button.dart';

/// Dialog that prompts the user to confirm an action before proceeding.
///
/// To be used with [showBottomSheetDialog].
class ConfirmationDialog extends StatelessWidget {
  /// Creates a confirmation dialog.
  const ConfirmationDialog({Key? key,
    required this.title,
    required this.subtitle,
    this.confirmText = 'Submit',
    this.cancelText = 'Cancel',
    this.confirmColor,
    this.cancelColor,
    required this.onSubmit,
  }) : super(key: key);

  /// The bold text displayed at the top of the dialog.
  final String title;

  /// The text displayed below the [title].
  final String subtitle;

  /// The text displayed on the right button used to confirm the action.
  final String confirmText;

  /// The text displayed on the left button used to cancel the action.
  final String cancelText;

  /// The color painted behind the confirm action.
  final Color? confirmColor;

  /// The color painted behind the cancel action.
  final Color? cancelColor;

  /// Called when the submit button is pressed.
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            title,
            style: mt(context).textStyle.heading2,
          ),
          const SizedBox(height: 22),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: mt(context).textStyle.body1,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              MButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                backgroundColor: cancelColor ?? mt(context).color.background,
                borderColor: mt(context).color.secondary,
                child: Text(
                  cancelText,
                  style: mt(context).textStyle.body1,
                ),
              ),
              const SizedBox(width: 15),
              MButton(
                onPressed: (){
                  onSubmit();
                  Navigator.pop(context);
                },
                backgroundColor: confirmColor ?? mt(context).color.primary,
                child: Text(
                  confirmText,
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
