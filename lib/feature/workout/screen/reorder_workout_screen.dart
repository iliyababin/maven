import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ReorderWorkoutScreen extends StatefulWidget {
  const ReorderWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ReorderWorkoutScreen> createState() => _ReorderWorkoutScreenState();
}

class _ReorderWorkoutScreenState extends State<ReorderWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        title: "Reorder",
        context: context
      ),
      body: Column(
        children: [
          Text("hey")
        ],
      ), 
    )
    ;
  }
}
