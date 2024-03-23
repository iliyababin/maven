
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../session/session.dart';
import '../transfer.dart';
import 'transfer_service.dart';

class TransferService {
  TransferService({
    required this.exercises,
    required this.importDao,
    required this.exportDao,
  });

  final List<Exercise> exercises;
  final ImportDao importDao;
  final ExportDao exportDao;

  /// Returns a list of imports from the database.
  Future<List<Import>> getImports() async {
    return await importDao.getAll();
  }

  Future<List<Export>> getExports() async {
    return await exportDao.getAll();
  }

  List<Session> parse(String csv, TransferSource source) {
    List<List<dynamic>> data = const CsvToListConverter(eol: '\n').convert(csv);

    List<CSVRow> rows = [];

    switch (source) {
      case TransferSource.strong:
        for(int i = 1; i < data.length; i++) {
          rows.add(StrongRow(data[i]));
        }
        break;
      case TransferSource.hevy:
        rows = data.map((e) => HevyRow(e)).toList();
        break;
      case TransferSource.json:
        // TODO: Handle this case.
        break;
    }

    List<Session> sessions = [];

    for (int i = 1; i < rows.length; i++) {
      CSVRow row = rows[i];

      int sessionIndex = sessions.indexWhere((element) {
        return element.routine.timestamp == DateTimeConverter().decode(row.date);
      });

      if (sessionIndex == -1) {
        sessions.add(Session(
          routine: Routine(
            timestamp: DateTimeConverter().decode(row.date),
            name: row.workoutName,
            type: RoutineType.session,
            note: 'BLANK',
          ),
          data: SessionData(
            routineId: -1,
            timeElapsed: TimedConverter().decode(int.parse(row.workoutDuration)),
          ),
          exerciseGroups: [],
        ));

        sessionIndex = sessions.length - 1;
      }

      Exercise? temp = exercises.firstWhereOrNull((element) {
        return element.conversions.where((element) {
          return element.name == row.exerciseName;
        }).toList().isNotEmpty;
      });

      if(temp == null) continue;


      int groupIndex = sessions[sessionIndex].exerciseGroups.indexWhere((element) {
        return element.exerciseId == temp.id;
      });

      if(groupIndex == -1) {
        sessions[sessionIndex].exerciseGroups.add(ExerciseGroupDto(
              exerciseId: temp.id!,
              distanceUnit: temp.distanceUnit,
              weightUnit: temp.weightUnit,
              timer: temp.timer,
              barId: temp.barId,
              routineId: -1,
              sets: [],
            ));

        groupIndex = sessions[sessionIndex].exerciseGroups.length - 1;
      }

      List<ExerciseSetDataDto> data = [];

      if (row.weight != '0') {
        data.add(ExerciseSetDataDto(
          fieldType: ExerciseFieldType.weight,
          value: row.weight,
          exerciseSetId: -1,
        ));
      }

      if (row.reps != '0') {
        data.add(ExerciseSetDataDto(
          fieldType: ExerciseFieldType.reps,
          value: row.reps,
          exerciseSetId: -1,
        ));
      }

      if(row.distance != '0') {
        data.add(ExerciseSetDataDto(
          fieldType: ExerciseFieldType.distance,
          value: row.distance,
          exerciseSetId: -1,
        ));
      }

      if(row.duration != '0') {
        data.add(ExerciseSetDataDto(
          fieldType: ExerciseFieldType.duration,
          value: row.duration,
          exerciseSetId: -1,
        ));
      }

      sessions[sessionIndex].exerciseGroups[groupIndex].sets.add(ExerciseSetDto(
            type: ExerciseSetType.regular,
            exerciseGroupId: -1,
            checked: true,
            data: data,
          ));
    }
    return sessions;
  }

  String export() {
    // TODO: implement export
    throw UnimplementedError();
  }

  /// Returns an import from the database.
  ///
  /// Throws an [Exception] if the import is not found.
  Future<Import> getImport(int importid) async {
    Import? import = await importDao.get(importid);

    if(import == null) {
      throw Exception('Import not found');
    }

    return import;
  }

  Future<Import> addImport(TransferSource source) async {
    int importId = await importDao.add(Import(
      timestamp: DateTime.now(),
      source: source,
    ));

    return await getImport(importId);
  }
}