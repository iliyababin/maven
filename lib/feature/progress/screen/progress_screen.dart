import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../../session/session.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
        title: 'Progress',
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
          child: CustomScrollView(
            slivers: [
              Heading(
                title: 'History',
                size: HeadingSize.small,
                actions: [
                  IconButton(
                    onPressed: () {
                      // TODO: Add calendar view
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Add filter
                    },
                    icon: const Icon(
                      Icons.sort,
                    ),
                  ),
                ],
              ),
              const SessionListView(),
            ],
          ),
        ));
  }
}
