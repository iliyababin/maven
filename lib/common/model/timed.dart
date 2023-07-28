class Timed {
  const Timed({
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
  });

  const Timed.zero()
      : hour = 0,
        minute = 0,
        second = 0;

  final int hour;
  final int minute;
  final int second;

  int toSeconds() {
    return (hour * 60 * 60) + (minute * 60) + second;
  }

  @override
  String toString() {
    if (hour == 0 && minute == 0 && second == 0) {
      return 'None';
    }

    String formattedTime = '';
    if (hour > 0) {
      formattedTime += '${hour}h ';
    }
    if (minute > 0) {
      formattedTime += '${minute}m ';
    }
    formattedTime += '${second}s';

    return formattedTime.trim();
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

  copyWith({
    int? hour,
    int? minute,
    int? second,
  }) {
    return Timed(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  Timed add(Timed timer) {
    return Timed(
      hour: hour + timer.hour,
      minute: minute + timer.minute,
      second: second + timer.second,
    );
  }
}