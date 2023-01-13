import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar build({
    required String title,
    required BuildContext context,
    List<Widget>? actions,
  }) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
          color: mt(context).text.accentColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: mt(context).text.primaryColor),
      ),
      centerTitle: true,
      elevation: 1,
      backgroundColor: mt(context).backgroundColor,
      actions: actions,
    );
  }
}
