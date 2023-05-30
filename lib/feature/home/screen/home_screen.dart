import 'package:maven/common/widget/heading.dart';
import 'package:maven/common/widget/titled_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../theme/widget/inherited_theme_widget.dart';

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
        padding: EdgeInsets.all(T(context).padding.page),
        child: const CustomScrollView(
          slivers: [
            Heading(title: 'Dashboard', topPadding: false,)
          ],
        )
      ),
    );
  }
}
