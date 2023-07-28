
import 'package:csv/csv.dart';
import 'package:maven/feature/external/data/strong_conversion_data.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../session/session.dart';
import '../external.dart';

class StrongService {
  const StrongService({
    required this.exercises,
  });

  final List<Exercise> exercises;

  List<Session> parse(String csv) {
    List<List<dynamic>> data = const CsvToListConverter(eol: '\n').convert(csv);

    List<Session> sessions = [];

    for (int i = 1; i < data.length; i++) {
      StrongRow row = StrongRow(data[i]);

      int sessionIndex = sessions.indexWhere((element) {
        return element.routine.timestamp == row.date;
      });

      if (sessionIndex == -1) {
        sessions.add(Session(
          routine: Routine(
            timestamp: row.date,
            name: row.workoutName,
            type: RoutineType.session,
            note: 'BLANK',
          ),
          data: SessionData(
            routineId: -1,
            timeElapsed: row.duration,
          ),
          exerciseGroups: [],
        ));

        sessionIndex = sessions.length - 1;
      }

      StrongConversion? conversion = getByExerciseName(row.exerciseName);

      if(conversion == null) continue;

      int groupIndex = sessions[sessionIndex].exerciseGroups.indexWhere((element) {
        return element.exerciseId == conversion.exerciseId;
      });

      if(groupIndex == -1) {
        Exercise exercise = exercises.firstWhere((element) {
          return element.id == conversion.exerciseId;
        });

        sessions[sessionIndex].exerciseGroups.add(ExerciseGroup(
          exerciseId: conversion.exerciseId,
          timer: row.seconds,
          weightUnit: exercise.weightUnit,
          distanceUnit: exercise.distanceUnit,
          barId: exercise.barId,
          routineId: null,
          sets: []
        ));

        groupIndex = sessions[sessionIndex].exerciseGroups.length - 1;
      }

      sessions[sessionIndex].exerciseGroups[groupIndex].sets.add(ExerciseSet(
        type: ExerciseSetType.regular,
        exerciseGroupId: -1,
        checked: true,
        data: conversion.convert(row),
      ));
    }

    return sessions;
  }
}