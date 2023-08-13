import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

class ColorScreen extends StatelessWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color'),
      ),
      body: ListView.builder(
        itemCount: T(context).color.colors.length,
        itemBuilder: (context, index) {
          String name = T(context).color.colors.keys.elementAt(index);
          Color color = T(context).color.colors.values.elementAt(index);
          return ListTile(
            onTap: () {},
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: color,
              ),
            ),
            title: Text(
              name,
              style: T(context).textStyle.bodyLarge,
            ),
          );
        },
      ),
    );
  }
}
