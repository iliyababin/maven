import 'package:flutter/material.dart';

import '../../theme/widget/inherited_theme_widget.dart';

enum HeadingSize {
  small,
  medium,
  large,
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.title,
    this.size = HeadingSize.large,
    this.side = false,
    this.actions = const [],
  }) : super(key: key);

  final String title;
  final HeadingSize size;
  final bool side;
  final List<IconButton> actions;

  double nice() {
    switch(size) {
      case HeadingSize.small:
        return 0;
      case HeadingSize.medium:
        return 16;
      case HeadingSize.large:
        return 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 12,
          top: nice(),
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
            if (actions.isNotEmpty)
              Row(
                children: actions.map(
                  (action) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: T(context).color.primaryContainer,
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(2),
                        constraints: BoxConstraints(),
                        onPressed: action.onPressed,
                        icon: action.icon,
                      ),
                    );
                  },
                ).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
