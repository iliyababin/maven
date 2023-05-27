import 'package:Maven/common/widget/heading.dart';
import 'package:Maven/common/widget/titled_scaffold.dart';
import 'package:Maven/feature/complete/widget/complete_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      body: Padding(
        padding: EdgeInsets.all(T.current.padding.page),
        child: const CustomScrollView(
          slivers: [
            Heading(title: 'History', topPadding: false,),
            CompleteListWidget(),
          ],
        ),
      )
    );
  }
}
