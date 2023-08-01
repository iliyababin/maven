
import 'package:maven/database/converter/converter.dart';
import 'package:maven/feature/transfer/model/csv_row.dart';

import '../../../common/model/timed.dart';

class StrongRow extends CSVRow {
  StrongRow(List<dynamic> row) : super(
    date: DateTimeConverter().encode(_convertStrongDate(row[0])),
    workoutName: row[1],
    workoutDuration: TimedConverter().encode(_convertStrongDuration(row[2])).toString(),
    exerciseName: row[3],
    duration: row[8].toString(),
    reps: row[6].toString(),
    weight: row[5].toString(),
    distance: row[7].toString(),
  );

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