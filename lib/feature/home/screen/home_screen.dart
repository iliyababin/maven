import 'package:flutter/material.dart';
import 'package:maven/common/widget/heading.dart';
import 'package:maven/common/widget/titled_scaffold.dart';

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
