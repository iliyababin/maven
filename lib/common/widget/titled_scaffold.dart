import 'package:flutter/cupertino.dart';

import '../../theme/m_themes.dart';

class TitledScaffold extends StatelessWidget {
  const TitledScaffold({Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: mt(context).color.background,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                title,
                style: TextStyle(
                  color: mt(context).textStyle.heading1.color,
                  fontWeight: mt(context).textStyle.heading1.fontWeight,
                ),
              ),
              backgroundColor: mt(context).color.background,
            )
          ];
        },
        body: body,
      ),
    );
  }
}
