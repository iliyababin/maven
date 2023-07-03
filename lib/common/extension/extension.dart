import 'package:flutter/material.dart';

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MuscleStringExtension on String {
  String parseMuscleToString() {
    String muscleString = toString().split('.').last;
    return muscleString.replaceAllMapped(
      RegExp(
        r'(?<=[a-z])([A-Z])',
      ),
          (match) => ' ${match.group(1)}',
    ).toLowerCase().capitalize;
  }
}

extension DateTimeExtension on DateTime {
  String timeLeft() {
    DateTime due = DateTime(
      year,
      month,
      day,
    );
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    Duration difference = due.difference(now);
    String timeRemaining;

    if (difference.isNegative) {
      timeRemaining = 'Past Due';
    } else if (difference.inDays > 0) {
      timeRemaining = 'Complete in ${difference.inDays} days';
    } else {
      timeRemaining = 'Complete Today';
    }
    return timeRemaining;
  }
}

extension ShimmerColorExtension on Color {
  Color get baseShimmer {
    return _darkenColor(this, amount: 0.05);
  }

  Color get highlightShimmer {
    return _darkenColor(this, amount: 0.1);
  }
}

Color _darkenColor(Color color, {double amount = 0.1}) {
  assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');

  final int alpha = color.alpha;
  final int red = (color.red * (1 - amount)).round();
  final int green = (color.green * (1 - amount)).round();
  final int blue = (color.blue * (1 - amount)).round();

  return Color.fromARGB(alpha, red, green, blue);
}