import 'package:flutter/material.dart';

import '../../theme/m_themes.dart';

class Heading extends StatelessWidget {
  const Heading({Key? key,
    required this.title,
    this.topPadding = true,
    this.side = false,
  }) : super(key: key);

  final String title;
  final bool topPadding;
  final bool side;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 12, top: topPadding ? 36 : 0,
          left: side ? mt(context).padding.page : 0,
          right: side ? mt(context).padding.page : 0,
        ),
        child: Text(
          title,
          style: mt(context).textStyle.heading4,
        ),
      ),
    );
  }
}
