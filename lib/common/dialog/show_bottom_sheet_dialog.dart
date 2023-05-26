import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

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
                    color: mt(context).color.background,
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