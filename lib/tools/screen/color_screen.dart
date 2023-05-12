import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

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
      style: mt(context).textStyle.body1,
    ),
    subtitle: description.isNotEmpty ? Text(
      description,
      style: mt(context).textStyle.subtitle1,
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
            mt(context).color.primary,
            'Text and Icons',
          ),
          color(
            'Secondary',
            mt(context).color.secondary,
            'Borders',
          ),
          color(
            'Background',
            mt(context).color.background,
            '',
          ),
          color(
            'Text',
            mt(context).color.text,
            '',
          ),
          color(
            'Subtext',
            mt(context).color.subtext,
            '',
          ),
          color(
            'Neutral',
            mt(context).color.neutral,
            'White',
          ),
          color(
            'Success',
            mt(context).color.success,
            '',
          ),
          color(
            'Error',
            mt(context).color.error,
            '',
          ),
        ],
      ),
    );
  }
}