import 'package:flutter/material.dart';

import '../../theme/model/app_theme.dart';
import 'color_screen.dart';
import 'padding_screen.dart';
import 'text_style_screen.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key? key}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ColorScreen(),));
            },
            title: Text(
              'Color',
              style: T.current.textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TextStyleScreen(),));
            },
            title: Text(
              'Text Style',
              style: T.current.textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaddingScreen(),));
            },
            title: Text(
              'Padding',
              style: T.current.textStyle.body1,
            ),
          ),
        ],
      ),
    );
  }
}
