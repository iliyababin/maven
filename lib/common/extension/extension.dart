import 'package:flutter/material.dart';

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
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

extension LightAdjustmentExtension on Color {
  Color balance (Brightness brightness) {
    final brightnessFactor = brightness == Brightness.dark ? 0.3 : 0.00001;
    return _darkenColor(this, amount: brightnessFactor);
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

extension RemoveTrailingZeros on String {
  String get truncateZeros {
    double? number = double.tryParse(this);

    if (number != null) {
      String result = number.toString();
      if (result.contains('.') && !result.contains('e')) {
        // Remove trailing zeros
        result = result.replaceAll(RegExp(r'0*$'), '');
        // Remove decimal if it only contains zeros
        if (result.endsWith('.')) {
          result = result.substring(0, result.length - 1);
        }
        return result;
      }
    }
    return this;
  }
}

extension RemoveTrailingZerosDouble on double {
  String get truncateZeros {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }
}