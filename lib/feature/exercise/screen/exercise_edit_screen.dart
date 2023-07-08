import 'package:flutter/material.dart';

class ExerciseEditScreen extends StatefulWidget {
  const ExerciseEditScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseEditScreen> createState() => _ExerciseEditScreenState();
}

class _ExerciseEditScreenState extends State<ExerciseEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Exercise'),
      ),
      body: const Center(
        child: Text('Exercise Edit Screen'),
      ),
    );
  }
}
