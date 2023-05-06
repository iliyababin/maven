extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MuscleStringExtension on String {
  String parseMuscleToString() {
    String muscleString = this.toString().split('.').last;
    return muscleString.replaceAllMapped(
      RegExp(
        r'(?<=[a-z])([A-Z])',
      ),
          (match) => ' ${match.group(1)}',
    ).toLowerCase().capitalize();
  }
}