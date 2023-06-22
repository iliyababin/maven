import 'package:flutter/material.dart';

import '../../theme/widget/inherited_theme_widget.dart';

class TitledScaffold extends StatelessWidget {
  const TitledScaffold({Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Padding(
          padding: EdgeInsetsDirectional.only(top: 30),
          child: Text(
            title,
            style: InheritedThemeWidget.of(context).theme.options.textStyle.headingLarge,
          ),
        ),
        backgroundColor: InheritedThemeWidget.of(context).theme.options.color.background,
        centerTitle: false,
        toolbarHeight: 100,

      ),
      body: body,
      /*CupertinoPageScaffold(
        backgroundColor: T(context).color.background,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                border: Border.all(style: BorderStyle.none),
                largeTitle: Text(
                  title,
                  style: TextStyle(
                    color: T(context).textStyle.heading1.color,
                    fontWeight: T(context).textStyle.heading1.fontWeight,
                  ),
                ),
                backgroundColor: T(context).color.background,
              ),
            ];
          },
          body: body,
        ),
      )*/
    );
  }
}
