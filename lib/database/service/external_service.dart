import 'package:csv/csv.dart';

import '../../common/common.dart';
import '../../feature/exercise/exercise.dart';
import '../../feature/session/session.dart';
import '../database.dart';

class ExternalService {
  /// Parses a CSV exported from the Strong app, and returns a list of sessions.
  ///
  /// The CSV must be in the following format:
  /// 1. Date
  /// 2. Workout Name
  /// 3. Duration
  /// 4. Exercise Name
  /// 5. Set Order
  /// 6. Weight
  /// 7. Reps
  /// 8. Distance
  /// 9. Seconds
  /// 10. Notes
  /// 11. Workout Notes
  /// 12. RPE
  static List<Session> strong(String string) {
    List<List<dynamic>> parsedData = const CsvToListConverter(eol: '\n').convert(string);

    List<Session> sessions = [];

    for (int i = 1; i < parsedData.length; i++) {
      /// Get the current row.
      List<dynamic> row = parsedData[i];

      /// Get the values from the row.
      String date = row[0];
      String workoutName = row[1];
      String duration = row[2];
      String exerciseName = row[3];
      dynamic setOrder = row[4];
      dynamic weight = row[5];
      dynamic reps = row[6];
      dynamic distance = row[7];
      dynamic seconds = row[8];
      String notes = row[9];
      String workoutNotes = row[10];
      dynamic rpe = row[11];

      /// Find the index of the session with the same date as the current row.
      int index = sessions.indexWhere((element) => element.routine.timestamp == _parseStrongDate(date));

      /// If the session wasn't found, add it to the list.
      if (index == -1) {
        sessions.add(Session(
          routine: Routine(
            timestamp: _parseStrongDate(date),
            name: workoutName,
            type: RoutineType.session,
            note: workoutNotes,
          ),
          data: SessionData(
            routineId: -1,
            timeElapsed: _parseStrongDuration(duration),
          ),
          exerciseGroups: [],
        ));

        index = sessions.indexWhere((element) => element.routine.timestamp == _parseStrongDate(date));
      }


      if(sessions[index].exerciseGroups.where((element) => element.exerciseId == StrongConversion.getExerciseId(exerciseName)).isEmpty) {
        if(StrongConversion.getExerciseId(exerciseName) != null) {
          sessions[index].exerciseGroups.add(ExerciseGroup(
            exerciseId: StrongConversion.getExerciseId(exerciseName) ?? 1,
            timer: Timed.fromSeconds(seconds ?? 0),
            weightUnit: WeightUnit.pound,
            distanceUnit: null,
            barId: null,
            routineId: null,
            sets: [],
          ));
        }
      }
    }
    return sessions;
  }

  static DateTime _parseStrongDate(String dateString) {
    // 2022-01-12 12:40:52
    List<String> dateAndTime = dateString.split(' ');
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

  static Timed _parseStrongDuration(String durationString) {
    List<String> parts = durationString.split(' ');

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

  /// Parses a CSV exported from the Hevy app, and returns a list of sessions.
  ///
  /// The CSV must be in the following format:
  /// 1. title
  /// 2. start_time
  /// 3. end_time
  /// 4. description
  /// 5. exercise_title
  /// 6. superset_id
  /// 7. exercise_notes
  /// 8. set_index
  /// 9. set_type
  /// 10. weight_lbs
  /// 11. reps
  /// 12. distance_miles
  /// 13. duration_seconds
  /// 14. rpe
  static List<dynamic> hevy(String string) {
    List<List<dynamic>> parsedData = const CsvToListConverter(eol: '\n').convert(string);

    List<Session> sessions = [];

    for (int i = 1; i < parsedData.length; i++) {
      List<dynamic> row = parsedData[i];
      dynamic title = row[0];
      dynamic startTime = row[1];
      dynamic endTime = row[2];
      dynamic description = row[3];
      dynamic exerciseTitle = row[4];
      dynamic supersetId = row[5];
      dynamic exerciseNotes = row[6];
      dynamic setIndex = row[7];
      dynamic setType = row[8];
      dynamic weightLbs = row[9];
      dynamic reps = row[10];
      dynamic distanceMiles = row[11];
      dynamic durationSeconds = row[12];
      dynamic rpe = row[13];

      if (title == null) {
        continue;
      }

      for (Session session in sessions) {
        if (session.routine == title) {}
      }
    }

    /*for(int i = 1; i < rows.length - 1; i++) {
      List<dynamic> row = rows[i];
      //String title = row[0];
      dynamic startTime = row[1];
      */ /*String endTime = row[2];
      String description = row[3];
      String exerciseTitle = row[4];
      String supersetId = row[5];
      String exerciseNotes = row[6];
      String setIndex = row[7];
      String setType = row[8];
      String weightLbs = row[9];
      String reps = row[10];
      String distanceMiles = row[11];
      String durationSeconds = row[12];
      String rpe = row[13];*/ /*

      print(startTime);
    }*/

    return [];
  }
}

class StrongConversion {
  const StrongConversion._(
    this.exerciseName,
    this.exerciseId,
  );

  final String exerciseName;
  final int exerciseId;

  static int? getExerciseId(String strongExerciseName) {
    for (StrongConversion conversion in _conversions) {
      if (conversion.exerciseName == strongExerciseName) {
        return conversion.exerciseId;
      }
    }
    return null;
  }

  static const List<StrongConversion> _conversions = [
    StrongConversion._(
      'Deadlift (Barbell)',
      8,
    ),
    StrongConversion._(
      'Bench Press (Barbell)',
      2,
    ),
    StrongConversion._(
      'Lat Pulldown (Cable)',
      9,
    ),
  ];
}
