import 'package:Maven/dev/screen/color_screen.dart';
import 'package:Maven/dev/screen/padding_screen.dart';
import 'package:Maven/dev/screen/text_style_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

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
              style: mt(context).textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TextStyleScreen(),));
            },
            title: Text(
              'Text Style',
              style: mt(context).textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaddingScreen(),));
            },
            title: Text(
              'Padding',
              style: mt(context).textStyle.body1,
            ),
          ),
        ],
      ),
    );
  }
}
