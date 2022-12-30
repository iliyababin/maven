import 'package:Maven/common/theme/app_themes.dart';
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
          color: colors(context).accentTextColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: colors(context).primaryTextColor),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: colors(context).backgroundColor,
      actions: actions,
    );
  }
}
