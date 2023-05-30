import 'package:maven/common/widget/heading.dart';
import 'package:maven/common/widget/titled_scaffold.dart';
import 'package:maven/feature/complete/widget/complete_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/widget/inherited_theme_widget.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      body: Padding(
        padding: EdgeInsets.all(T(context).padding.page),
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
