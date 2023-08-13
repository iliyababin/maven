import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

class ListDialog extends StatelessWidget {
  const ListDialog({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 2),
            height: 16,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 6,
              width: 48,
              decoration: BoxDecoration(
                color: T(context).color.outline,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          ...children,
          Container(height: 12,)
        ],
      ),
    );
  }
}
