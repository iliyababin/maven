import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maven/common/common.dart';

import '../../theme/theme.dart';

class SessionWeeklyGoalWidget extends StatefulWidget {
  const SessionWeeklyGoalWidget({
    Key? key,
    required this.goal,
    required this.onModified,
    required this.dates,
  }) : super(key: key);

  final int goal;
  final Function(int value) onModified;
  final List<DateTime> dates;

  @override
  State<SessionWeeklyGoalWidget> createState() => _SessionWeeklyGoalWidgetState();
}

class _SessionWeeklyGoalWidgetState extends State<SessionWeeklyGoalWidget> {
  DateTime day = DateTime.now();
  Map<DateTime, int> data = {};

  void calculatedata() {
    data.clear();
    day = DateTime.now();
    List<DateTime> dates = widget.dates.map((e) => DateUtils.dateOnly(e)).toList();
    day = day.subtract(const Duration(days: 42));

    for (int week = 0; week < 6; week++) {
      data[day.add(Duration(days: week * 7))] = 0;

      for (int temp = 1; temp <= 7; temp++) {
        DateTime calculatedDay = DateUtils.dateOnly(day.add(Duration(days: week * 7 + temp)));
        if (dates.contains(calculatedDay)) {
          data[day.add(Duration(days: week * 7))] = data[day.add(Duration(days: week * 7))]! + dates.where((element) => element == calculatedDay).length;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    calculatedata();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          T(context).shape.large,
        ),
        color: T(context).color.surface,
      ),
      padding: EdgeInsets.all(
        T(context).space.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Workouts Per Week',
                style: T(context).textStyle.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  showBottomSheetDialog(
                    context: context,
                    child: TextInputDialog(
                      title: 'Goal',
                      initialValue: widget.goal.toString(),
                      onValueSubmit: (value) {
                        widget.onModified(int.parse(value));
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.all(
                    T(context).space.small,
                  ),
                  foregroundColor: T(context).color.onSurfaceVariant,
                ),
                child: Text(
                  'Goal: ${widget.goal}',
                  style: T(context).textStyle.labelSmall,
                ),
              ),
            ],
          ),
          SizedBox(
            height: T(context).space.medium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              data.length,
              (index) {
                final day = data.keys.elementAt(index);
                final amount = data[day]!;
                return Column(
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CustomPaint(
                        painter: PercentRingPainter(
                          percentFilled: amount == 0 ? 0 : amount / widget.goal,
                          errorColor: T(context).color.error,
                          completedColor: T(context).color.success,
                          ringColor: T(context).color.outline,
                          fillColor: T(context).color.onSecondaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: T(context).space.small,
                    ),
                    Text(
                      DateFormat('Md').format(day),
                      style: T(context).textStyle.labelSmall,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PercentRingPainter extends CustomPainter {
  double percentFilled;
  Color ringColor;
  Color fillColor;
  Color completedColor;
  Color errorColor;

  PercentRingPainter({
    required this.percentFilled,
    required this.ringColor,
    required this.fillColor,
    required this.completedColor,
    required this.errorColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = size.width / 2.5;

    if (percentFilled > 0) {
      ringColor = ringColor;
    } else {
      ringColor = ringColor;
    }

    fillColor = completedColor;

    // Draw the ring
    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, ringPaint);

    // Calculate the angle to fill based on the percent
    final fillAngle = 2 * pi * percentFilled;

    // Draw the filled portion
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start angle at -90 degrees (top)
      fillAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
