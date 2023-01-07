import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

class CustomScaffold {
  static Scaffold build({
    AppBar? appBar,
    required Widget body,
    required BuildContext context,
    FloatingActionButton? floatingActionButton,
  }) {
    return Scaffold(
      backgroundColor: mt(context).backgroundColor,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
