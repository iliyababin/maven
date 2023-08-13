import 'package:flutter/material.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

import '../../feature/theme/theme.dart';
import 'color_screen.dart';
import 'padding_screen.dart';
import 'text_style_screen.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Design',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ColorScreen(),
                ),
              );
            },
            title: Text(
              'Color',
              style: T(context).textStyle.bodyLarge,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TextStyleScreen(),
                ),
              );
            },
            title: Text(
              'Text Style',
              style: T(context).textStyle.bodyLarge,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaddingScreen(),
                ),
              );
            },
            title: Text(
              'Padding',
              style: T(context).textStyle.bodyLarge,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DatabaseList(),
                ),
              );
            },
            title: Text(
              'Database',
              style: T(context).textStyle.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
