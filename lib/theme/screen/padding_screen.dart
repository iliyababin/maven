import 'package:flutter/material.dart';

import '../widget/inherited_theme_widget.dart';

class PaddingScreen extends StatelessWidget {
  const PaddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Padding',
        ),
      ),
      body: ListView.builder(
        itemCount: T(context).padding.paddings.length,
        itemBuilder: (context, index) {
          String paddingName = T(context).padding.paddings.keys.elementAt(index);
          double value = T(context).padding.paddings.values.elementAt(index);
          return ListTile(
            onTap: () {},
            title: Text(
              paddingName,
              style: T(context).textStyle.bodyLarge,
            ),
            subtitle: Text(
              'Padding: $value',
              style: T(context).textStyle.bodyMedium,
            ),
          );
        },
      ),
    );
  }
}
