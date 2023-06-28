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
          left: side ? T(context).space.large : 0,
          right: side ? T(context).space.large : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: T(context).textStyle.titleMedium,
            ),
            if (false)
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: T(context).color.primaryContainer,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(2),
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.sort,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 6,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: T(context).color.primaryContainer,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(2),
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.add,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
