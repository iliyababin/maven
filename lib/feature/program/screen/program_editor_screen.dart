import 'package:flutter/material.dart';

class ProgramEditorScreen extends StatelessWidget {
  const ProgramEditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Program Editor',
        ),
      ),
    );
  }
}
