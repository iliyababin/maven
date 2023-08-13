import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

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
        itemCount: T(context).space.spacings.length,
        itemBuilder: (context, index) {
          String paddingName = T(context).space.spacings.keys.elementAt(index);
          double value = T(context).space.spacings.values.elementAt(index);
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
