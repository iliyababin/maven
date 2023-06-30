import 'package:flutter/material.dart';

import '../../../common/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const TitledScaffold(
      title: 'Home',
      body: CustomScrollView(
        slivers: [
          Heading(
            title: 'Dashboard',
            side: true,
            size: HeadingSize.small,
          )
        ],
      ),
    );
  }
}
