
import '../../../common/model/timed.dart';

class StrongRow {
  StrongRow(List<dynamic> row) {
    assert(row.length == 12);
    assert(row[0] != null);
    date = _convertStrongDate(row[0]);
    workoutName = row[1];
    duration = _convertStrongDuration(row[2]);
    exerciseName = row[3];
    /// setOrder = row[4];
    weight = row[5];
    reps = row[6];
    distance = row[7];
    seconds = Timed.fromSeconds(row[8]);
    /// notes = row[9];
    /// workoutNotes = row[10];
    /// rpe = row[11];
  }

  late DateTime date;
  late String workoutName;
  late Timed duration;
  late String exerciseName;
  late dynamic weight;
  late dynamic reps;
  late dynamic distance;
  late Timed seconds;

  static DateTime _convertStrongDate(String string) {
    List<String> dateAndTime = string.split(' ');
    List<String> dateComponents = dateAndTime[0].split('-');
    List<String> timeComponents = dateAndTime[1].split(':');

    int year = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int day = int.parse(dateComponents[2]);
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);
    int second = int.parse(timeComponents[2]);

    return DateTime(year, month, day, hour, minute, second);
  }

  static Timed _convertStrongDuration(String string) {
    List<String> parts = string.split(' ');

    int hours = 0;
    int minutes = 0;

    for (String part in parts) {
      if (part.contains('h')) {
        hours = int.parse(part.replaceAll('h', ''));
      } else if (part.contains('m')) {
        minutes = int.parse(part.replaceAll('m', ''));
      }
    }

    return Timed.fromSeconds((hours * 3600) + (minutes * 60));
  }
}