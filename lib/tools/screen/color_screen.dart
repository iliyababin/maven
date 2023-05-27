import 'package:Maven/theme/model/app_theme.dart';
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
      style: T.current.textStyle.body1,
    ),
    subtitle: description.isNotEmpty ? Text(
      description,
      style: T.current.textStyle.subtitle1,
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
            T.current.color.primary,
            'Text and Icons',
          ),
          color(
            'Secondary',
            T.current.color.secondary,
            'Borders',
          ),
          color(
            'Background',
            T.current.color.background,
            '',
          ),
          color(
            'Text',
            T.current.color.text,
            '',
          ),
          color(
            'Subtext',
            T.current.color.subtext,
            '',
          ),
          color(
            'Neutral',
            T.current.color.neutral,
            'White',
          ),
          color(
            'Success',
            T.current.color.success,
            '',
          ),
          color(
            'Error',
            T.current.color.error,
            '',
          ),
        ],
      ),
    );
  }
}