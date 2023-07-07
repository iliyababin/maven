import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Home',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: const CustomScrollView(
          slivers: [
            Heading(
              title: 'Dashboard',
              size: HeadingSize.small,
            ),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }
}
