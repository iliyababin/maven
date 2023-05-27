import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(
              color: T.current.color.secondary,
            )
        ),
        alignment: FractionalOffset.center,
        child: Text(
          'Empty',
          style: T.current.textStyle.subtitle1,
        ),
      ),
    );
  }
}
