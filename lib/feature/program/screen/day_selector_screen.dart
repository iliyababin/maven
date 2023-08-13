import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';


class DaySelectorScreen extends StatefulWidget {
  const DaySelectorScreen({
    Key? key,
    required this.day,
  }) : super(key: key);

  final Day day;

  @override
  State<DaySelectorScreen> createState() => _DaySelectorScreenState();
}

class _DaySelectorScreenState extends State<DaySelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day',
        ),
      ),
      body: ListView.builder(
        itemCount: Day.values.length,
        itemBuilder: (context, index) {
          Day day = Day.values[index];
          return ListTile(
            onTap: () {
              Navigator.pop(context, day);
            },
            title: Text(
              capitalize(day.name),
              style: T(context).textStyle.bodyLarge,
            ),
            trailing: widget.day == day
                ? const Icon(
                    Icons.check,
                  )
                : null,
          );
        },
      ),
    );
  }
}
