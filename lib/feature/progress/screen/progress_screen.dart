import 'package:flutter/material.dart';
import 'package:maven/common/widget/heading.dart';
import 'package:maven/common/widget/titled_scaffold.dart';

import '../../../theme/widget/inherited_theme_widget.dart';
import '../../session/widget/complete_list_widget.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: const CustomScrollView(
          slivers: [
            Heading(title: 'History', size: HeadingSize.small),
            CompleteListWidget(),
          ],
        ),
      )
    );
  }
}
