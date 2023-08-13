import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

class TextStyleScreen extends StatelessWidget {
  const TextStyleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Style',
        ),
      ),
      body: ListView.builder(
        itemCount: T(context).textStyle.textStyles.length,
        itemBuilder: (context, index) {
          String textStyleName = T(context).textStyle.textStyles.keys.elementAt(index);
          TextStyle textStyle = T(context).textStyle.textStyles.values.elementAt(index);
          return ListTile(
            onTap: () {},
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
