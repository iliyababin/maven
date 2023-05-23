import 'package:flutter/material.dart';

import '../model/complete_bundle.dart';

class CompleteDetailScreen extends StatelessWidget {
  const CompleteDetailScreen({Key? key,
    required this.completeBundle,
  }) : super(key: key);

  final CompleteBundle completeBundle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'complete-detail-title',
          child: Text('Complete Detail'),
        ),
      ),
    );
  }
}
