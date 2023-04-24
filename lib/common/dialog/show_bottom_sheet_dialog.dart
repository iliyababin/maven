import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

void showBottomSheetDialog({
  required BuildContext context,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(18),
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
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
      );
    },
  ).whenComplete(() => onClose());
}