import 'package:flutter/material.dart';

import '../../theme/model/app_theme.dart';

void showBottomSheetDialog({
  required BuildContext context,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(18),
  required Widget child,
  VoidCallback? onClose,
  double height = 330,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: T.current.color.background,
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() {
    if(onClose != null) onClose();
  });
}