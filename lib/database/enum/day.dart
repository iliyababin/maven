enum Day {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension DayExtension on Day {
  String getAbbreviation() {
    switch (this) {
      case Day.sunday:
        return 'Sun';
      case Day.monday:
        return 'Mon';
      case Day.tuesday:
        return 'Tue';
      case Day.wednesday:
        return 'Wed';
      case Day.thursday:
        return 'Thu';
      case Day.friday:
        return 'Fri';
      case Day.saturday:
        return 'Sat';
      default:
        throw UnimplementedError();
    }
  }
}