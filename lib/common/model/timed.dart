class Timed {
  int hour;
  int minute;
  int second;

  Timed({
    required this.hour,
    required this.minute,
    required this.second
  });

  int toSeconds() {
    return (hour * 60 * 60) + (minute * 60) + second;
  }
}