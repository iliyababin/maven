import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/widget/inherited_theme_widget.dart';

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
          left: side ? T(context).padding.page : 0,
          right: side ? T(context).padding.page : 0,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: T(context).textStyle.heading4,
            ),
            Expanded(child: Container()),
           /* if (!side)
              SizedBox(
                child: IconButton(
                  padding: EdgeInsets.all(2),
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.sort_down),

                ),
              ),*/
          ],
        ),
      ),
    );
  }
}
