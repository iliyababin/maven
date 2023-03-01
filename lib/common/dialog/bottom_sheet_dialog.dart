import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

void showBottomSheetDialog({
  required BuildContext context,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(15),
  required Widget child,
  required VoidCallback onClose,
  double height = 330,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  color: mt(context).backgroundColor,
                ),
                child: child,
              ),
            ),
          ),
        ],
      );
    },
  ).whenComplete(() => onClose());
}