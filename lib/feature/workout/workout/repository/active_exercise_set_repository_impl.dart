
import 'package:sqflite/sqflite.dart';

import '../../../../common/model/active_exercise_set.dart';
import '../../../../common/util/database_helper.dart';
import 'active_exercise_set_repository.dart';

class ActiveExerciseSetRepositoryImpl implements ActiveExerciseSetRepository {

  final DBHelper _dbHelper;

  ActiveExerciseSetRepositoryImpl(this._dbHelper);

  @override
  Future<int> addActiveExerciseSet(ActiveExerciseSet activeExerciseSet) async {
    final Database db = await _dbHelper.database;
    return await db.insert('activeExerciseSet', activeExerciseSet.toMap());
  }

  @override
  Future<List<ActiveExerciseSet>> getActiveExerciseSets() async {
    final Database db = await _dbHelper.database;
    var activeExerciseSets = await db.query('activeExerciseSet');
    List<ActiveExerciseSet> activeExerciseSetList = activeExerciseSets.isNotEmpty
        ? activeExerciseSets.map((c) => ActiveExerciseSet.fromMap(c)).toList()
        : [];
    return activeExerciseSetList;
  }

  @override
  Future<List<ActiveExerciseSet>> getActiveExerciseSetsByActiveExerciseGroupId(int activeExerciseGroupId) async {
    final Database db = await _dbHelper.database;
    var activeExerciseSets = await db.query(
      'activeExerciseSet',
      where: 'activeExerciseGroupId = ?',
      whereArgs: [activeExerciseGroupId],
    );
    List<ActiveExerciseSet> activeExerciseSetsList = activeExerciseSets.isNotEmpty
        ? activeExerciseSets.map((c) => ActiveExerciseSet.fromMap(c)).toList()
        : [];
    return activeExerciseSetsList;
  }

  @override
  Future<int> updateActiveExerciseSet(ActiveExerciseSet activeExerciseSet) async {
    final Database db = await _dbHelper.database;
    return await db.update(
      'activeExerciseSet',
      activeExerciseSet.toMap(),
      where: 'activeExerciseSetId = ?',
      whereArgs: [activeExerciseSet.activeExerciseSetId],
    );
  }

  @override
  Future<int> deleteActiveExerciseSet(int activeExerciseSetId) async {
    final Database db = await _dbHelper.database;
    return await db.delete('activeExerciseSet',
        where: 'activeExerciseSetId = ?', whereArgs: [activeExerciseSetId]);
  }

  @override
  Future<void> deleteActiveExerciseSetsByWorkoutId(int workoutId) async {
    final Database db = await _dbHelper.database;
    List<Map<String, dynamic>> activeExerciseSets = await db
        .query('activeExerciseSet', where: 'workoutId = ?', whereArgs: [workoutId]);
    for (var activeExerciseSet in activeExerciseSets) {
      await deleteActiveExerciseSet(activeExerciseSet['activeExerciseSetId']);
    }
  }

}
