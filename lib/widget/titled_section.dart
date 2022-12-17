import 'package:flutter/material.dart';

class TitledSection extends StatelessWidget {
  const TitledSection({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title),
        child
      ],
    );
  }
}
