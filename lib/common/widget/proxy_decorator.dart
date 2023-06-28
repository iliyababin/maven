import 'package:flutter/material.dart';

import '../../theme/theme.dart';

Widget ProxyDecorator(widget, index, animation, context) {
  final scale = Tween<double>(begin: 1, end: 1.05).animate(animation);
  final shadow = BoxShadow(
    color: T(context).color.shadow,
    blurRadius: 8,
    offset: const Offset(0, 0),
  );
  return ScaleTransition(
    scale: scale,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow],
      ),
      child: widget,
    ),
  );
}