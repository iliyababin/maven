import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class TextStyleScreen extends StatefulWidget {
  const TextStyleScreen({Key? key}) : super(key: key);

  @override
  State<TextStyleScreen> createState() => _TextStyleScreenState();
}

class _TextStyleScreenState extends State<TextStyleScreen> {
  ListTile textStyle(String title, TextStyle textStyle, String description) => ListTile(
    onTap: (){

    },
    title: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        title,
        style: textStyle,
      ),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8,),
      child: Text(
        description,
        maxLines: 4,
        style: mt(context).textStyle.subtitle1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Style',
        ),
      ),
      body: ListView(
        children: [
          textStyle(
            'Heading 1',
            mt(context).textStyle.heading1,
            'Use in title of screens',
          ),
          textStyle(
            'Heading 2',
            mt(context).textStyle.heading2,
            'Use to separate sections on a screen',
          ),
          textStyle(
            'Heading 3',
            mt(context).textStyle.heading3,
            'Use to show something important in widgets',
          ),
          textStyle(
            'Body 1',
            mt(context).textStyle.body1,
            'Use anywhere to display regular text',
          ),
          textStyle(
            'Subtitle 1',
            mt(context).textStyle.subtitle1,
            'Use under body1 or any insignificant text.',
          ),
          textStyle(
            'Subtitle 2',
            mt(context).textStyle.subtitle2,
            'Use under heading3',
          ),
          textStyle(
            'Button 1',
            mt(context).textStyle.button1,
            'Use in buttons with a primary background color',
          ),
          textStyle(
            'Button 2',
            mt(context).textStyle.button2,
            'Use in buttons with no background color',
          ),
        ],
      ),
    );
  }
}
