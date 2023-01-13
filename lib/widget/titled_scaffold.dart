
import 'package:flutter/cupertino.dart';

import '../theme/m_themes.dart';

class TitledScaffold {
  static CupertinoPageScaffold build({
    required BuildContext context,
    required String title,
    required Widget body,
  }) {
    return CupertinoPageScaffold(
      backgroundColor: mt(context).backgroundColor,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                title,
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                ),
              ),
              backgroundColor: mt(context).sliverNavigationBarBackgroundColor,
            )
          ];
        },
        body: body,
      ),
    );
  }
}
