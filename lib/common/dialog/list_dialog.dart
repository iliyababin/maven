import 'package:flutter/material.dart';

class ListDialog extends StatelessWidget {
  const ListDialog({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<ListTile> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: children,
    );
  }
}
