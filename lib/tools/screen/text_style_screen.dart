import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
        itemCount: T.current.textStyle.textStyles.length,
        itemBuilder: (context, index) {
          String textStyleName =  T.current.textStyle.textStyles.keys.elementAt(index);
          TextStyle textStyle = T.current.textStyle.textStyles.values.elementAt(index);
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
