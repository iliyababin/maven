extension StringExtension on String {
  String capitalize() {
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
    ).toLowerCase().capitalize();
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