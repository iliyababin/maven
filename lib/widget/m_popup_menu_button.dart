import 'package:flutter/material.dart';

class MPopupMenuButton extends StatelessWidget {

  final List<PopupMenuItem> children;
  final Color iconColor;
  final Color color;

  const MPopupMenuButton({super.key,
    required this.children,
    required this.iconColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return children;
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      offset: Offset.fromDirection(2, 30),
      color: color,
      child: Icon(
        Icons.more_vert,
        color: iconColor,
      ),
    );
  }
}
