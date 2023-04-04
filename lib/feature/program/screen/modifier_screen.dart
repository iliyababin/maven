import 'package:Maven/feature/program/model/Modifier.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../exercise/model/exercise.dart';

class ModifierScreen extends StatelessWidget {
  const ModifierScreen({Key? key,
    required this.modifiers,
    required this.exercises,
  }) : super(key: key);

  final List<Modifier> modifiers;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modifiers',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
      ),
    );
  }
}
