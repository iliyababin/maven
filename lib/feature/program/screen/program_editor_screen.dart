import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class ProgramEditorScreen extends StatelessWidget {
  const ProgramEditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Program Editor',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
      ),
    );
  }
}
