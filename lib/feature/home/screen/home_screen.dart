import 'package:Maven/common/widget/heading.dart';
import 'package:Maven/common/widget/titled_scaffold.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(mt(context).padding.page),
        child: const CustomScrollView(
          slivers: [
            Heading(title: 'Dashboard', topPadding: false,)
          ],
        )
      ),
    );
  }
}
