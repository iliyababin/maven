import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class TextStyleScreen extends StatefulWidget {
  const TextStyleScreen({Key? key}) : super(key: key);

  @override
  State<TextStyleScreen> createState() => _TextStyleScreenState();
}

class _TextStyleScreenState extends State<TextStyleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Style',
        ),
      ),
      body: ListView.builder(
        itemCount: mt(context).textStyle.namedStyles.length,
        itemBuilder: (context, index) {
          String textStyleName =  mt(context).textStyle.namedStyles.keys.elementAt(index);
          TextStyle textStyle = mt(context).textStyle.namedStyles.values.elementAt(index);
          return ListTile(
            onTap: (){},
            title: Text(
              textStyleName,
              style: textStyle,
            ),
          );
        },
      ),
    );
  }
}
