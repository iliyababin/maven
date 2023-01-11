import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String subtext,
}) async {

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: mt(context).dialog.backgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: mt(context).text.primaryColor
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: [
                  Text(
                    subtext,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: mt(context).text.primaryColor
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 6, 10, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Discard',
                      style: TextStyle(
                        color: mt(context).text.errorColor,
                        fontSize: 17
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}