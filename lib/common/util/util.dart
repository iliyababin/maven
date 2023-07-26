import 'package:maven/common/common.dart';

import '../../database/database.dart';

String workoutDuration(DateTime startTime) {
  Duration difference = DateTime.now().difference(startTime);
  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;
  if (hours == 0) {
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

String parseMuscleCoverage(Map<Muscle, double> musclePercentages) {
  String result = '';
  musclePercentages.forEach((key, value) {
    result += '${key.name.capitalize}: ${(value * 100).truncate()}%\n';
  });
  return result;
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

String secondsToTime(int seconds) {
  int hours = (seconds / 3600).floor();
  int minutes = ((seconds % 3600) / 60).floor();
  int remainingSeconds = seconds % 60;
  String time = "";
  if(hours != 0) {
    time += "$hours:";
  }
  if(minutes < 10) {
    time += "$minutes:";
  } else {
    time += "$minutes:";
  }
  if(remainingSeconds < 10) {
    time += "0$remainingSeconds";
  } else {
    time += "$remainingSeconds";
  }
  return time;
}

/// method which takes in duration and outputs how long it took like 1h 30m 10s
String durationToTime(Duration duration) {
  String time = "";
  if(duration.inHours != 0) {
    time += "${duration.inHours}h ";
  }
  if(duration.inMinutes % 60 != 0) {
    time += "${duration.inMinutes % 60}m";
  }
  if(duration.inSeconds % 60 != 0) {
    time += " ${duration.inSeconds % 60}s";
  }
  return time;
}

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}

String formatDate(DateTime dateTime) {
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  final year = dateTime.year.toString();
  return '$month/$day/$year';
}