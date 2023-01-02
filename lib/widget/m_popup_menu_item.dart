import 'package:flutter/material.dart';

class MPopupMenuItem  {

  static PopupMenuItem<dynamic> build({
    required Icon icon,
    required String text,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem<dynamic>(
        height: 35,
        onTap: onTap,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10,),
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            ),
          ],
        )
    );
  }

}
