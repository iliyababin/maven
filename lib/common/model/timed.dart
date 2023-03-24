

class Timed {
  Timed({
    required this.hour,
    required this.minute,
    required this.second
  });

  int hour;
  int minute;
  int second;

  factory Timed.zero() => Timed(hour: 0, minute: 0, second: 0);

  int toSeconds() {
    return (hour * 60 * 60) + (minute * 60) + second;
  }

  @override
  String toString() {
    if(hour == 0 && minute == 0 && second == 0) return 'None';
    return "$hour:$minute:$second";
  }

  static Timed fromSeconds(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = (seconds % 3600) ~/ 60;
    int second = seconds % 60;
    return Timed(
      hour: hour,
      minute: minute,
      second: second,
    );
  }
}