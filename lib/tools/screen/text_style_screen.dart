import 'package:Maven/theme/model/app_theme.dart';
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
        itemCount: T.current.textStyle.namedStyles.length,
        itemBuilder: (context, index) {
          String textStyleName =  T.current.textStyle.namedStyles.keys.elementAt(index);
          TextStyle textStyle = T.current.textStyle.namedStyles.values.elementAt(index);
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
