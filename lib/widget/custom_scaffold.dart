import 'package:Maven/data/app_themes.dart';
import 'package:flutter/material.dart';

class CustomScaffold {
  static Scaffold build({
    AppBar? appbar,
    required Widget body,
    required BuildContext context,
    FloatingActionButton? floatingActionButton,
  }) {
    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      appBar: appbar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
