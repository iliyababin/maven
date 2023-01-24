import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

void showBottomSheetDialog({
  required BuildContext context,
  double height = 330,
  Alignment alignment = Alignment.center,
  EdgeInsets padding = const EdgeInsets.all(15),
  required Widget child,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: mt(context).backgroundColor,
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15)
          )
        ),
        height: height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 5,
              width: 42,
              decoration: BoxDecoration(
                  color: mt(context).handleBarColor,
                  borderRadius: BorderRadius.circular(100)
              ),
            ),

            Expanded(child: child)
            /*Container(
              alignment: alignment,
              padding: padding,
              child: child,
            )*/
          ],
        ),
      );
    },
  );
}