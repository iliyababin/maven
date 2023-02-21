import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

void showBottomSheetDialog({
  required BuildContext context,
  double height = 330,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(15),
  required Widget child,
  required VoidCallback onClose,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              color: mt(context).backgroundColor,

            ),
            height: height,
            child: Column(
              children: [
             /*   Container(
                  height: 5,
                  width: 42,
                  decoration: BoxDecoration(
                      color: mt(context).handleBarColor,
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
*/
                Expanded(child: child)
                /*Container(
                  alignment: alignment,
                  padding: padding,
                  child: child,
                )*/
              ],
            ),
          ),
        ),
      );
    },
  ).whenComplete(() => onClose());
}