import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

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
    this.confirmButtonStyle,
    this.cancelButtonStyle,
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
  final ButtonStyle? confirmButtonStyle;

  /// The color painted behind the cancel action.
  final ButtonStyle? cancelButtonStyle;

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
            style: T(context).textStyle.titleLarge,
          ),
          const SizedBox(height: 22),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: T(context).textStyle.bodyLarge,
            maxLines: 9,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: cancelButtonStyle,
                  child: Text(
                    cancelText,
                    style: T(context).textStyle.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: FilledButton(
                  onPressed: (){
                    onSubmit();
                    Navigator.pop(context);
                  },
                  style: confirmButtonStyle,
                  child: Text(
                    confirmText,
                    style: T(context).textStyle.labelLarge,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
