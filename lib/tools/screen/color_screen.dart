import 'package:flutter/material.dart';

import '../../theme/widget/inherited_theme_widget.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  ListTile color(String name, Color color, String description) => ListTile(
    onTap: () {

    },
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
      style: T(context).textStyle.body1,
    ),
    subtitle: description.isNotEmpty ? Text(
      description,
      style: T(context).textStyle.subtitle1,
    ) : null,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color'),
      ),
      body: ListView(
        children: [
          color(
            'Primary',
            T(context).color.primary,
            'Text and Icons',
          ),
          color(
            'Secondary',
            T(context).color.secondary,
            'Borders',
          ),
          color(
            'Background',
            T(context).color.background,
            '',
          ),
          color(
            'Text',
            T(context).color.text,
            '',
          ),
          color(
            'Subtext',
            T(context).color.subtext,
            '',
          ),
          color(
            'Neutral',
            T(context).color.neutral,
            'White',
          ),
          color(
            'Success',
            T(context).color.success,
            '',
          ),
          color(
            'Error',
            T(context).color.error,
            '',
          ),
        ],
      ),
    );
  }
}