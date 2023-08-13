import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:maven/common/common.dart';

import '../../theme/theme.dart';
import '../../settings/settings.dart';
import '../session.dart';

class SessionAboutView extends StatelessWidget {
  const SessionAboutView({
    Key? key,
    required this.session,
  }) : super(key: key);

  final Session session;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(T(context).space.large),
          decoration: BoxDecoration(
            color: T(context).color.surface,
            borderRadius: BorderRadius.circular(T(context).shape.large),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.routine.name,
                style: T(context).textStyle.headingMedium,
              ),
              MarkdownBody(
                data: session.routine.note,
              )
            ],
          ),
        ),
        SizedBox(
          height: T(context).space.medium,
        ),
        Container(
          padding: EdgeInsets.all(T(context).space.large),
          decoration: BoxDecoration(
            color: T(context).color.surface,
            borderRadius: BorderRadius.circular(T(context).shape.large),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: T(context).textStyle.titleLarge,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(
                    children: [
                      const Text(
                        'Duration',
                      ),
                      Text(
                        session.data.timeElapsed.toString(),
                        style: T(context).textStyle.labelSmall,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Completed',
                      ),
                      Text(
                        DateFormat.yMd().add_jm().format(session.routine.timestamp),
                        style: T(context).textStyle.labelSmall,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: T(context).space.medium,
        ),
        Container(
          padding: EdgeInsets.all(T(context).space.large),
          decoration: BoxDecoration(
            color: T(context).color.surface,
            borderRadius: BorderRadius.circular(T(context).shape.large),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exercises',
                style: T(context).textStyle.titleLarge,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(
                    children: [
                      const Text(
                        'Volume',
                      ),
                      Text(
                        s(context).parseWeight(session.volume).truncateZeros,
                        style: T(context).textStyle.labelSmall,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Coverage',
                      ),
                      Text(
                        parseMuscleCoverage(session.musclePercentages),
                        style: T(context).textStyle.labelSmall,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
