import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../feature/theme/theme.dart';


class TitledScaffold extends StatelessWidget {
  const TitledScaffold({Key? key,
    required this.title,
    required this.slivers,
  }) : super(key: key);

  final String title;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              title,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: T(context).space.large,
            ),
            sliver: MultiSliver(
              children: slivers,
            )
          ),
        ],
      )
    );
  }
}
