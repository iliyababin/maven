import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';


void showBottomSheetDialog({
  required BuildContext context,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(18),
  required Widget child,
  VoidCallback? onClose,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: T(context).color.background,
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