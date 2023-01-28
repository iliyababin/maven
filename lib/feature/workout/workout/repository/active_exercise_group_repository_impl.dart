import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../common/util/database_helper.dart';
import 'active_exercise_group_repository.dart';

class ActiveExerciseGroupRepositoryImpl implements ActiveExerciseGroupRepository {

  final DBHelper _dbHelper;

  ActiveExerciseGroupRepositoryImpl(this._dbHelper);

  @override
  Future<int> addActiveExerciseGroup(ActiveExerciseGroup activeExerciseGroup) async {
    final Database db = await _dbHelper.database;
    return await db.insert('activeExerciseGroup', activeExerciseGroup.toMap());
  }

  @override
  Future<List<ActiveExerciseGroup>> getActiveExerciseGroups() async {
    final Database db = await _dbHelper.database;
    var activeExerciseGroups = await db.query('activeExerciseGroup');
    List<ActiveExerciseGroup> activeExerciseGroupList = activeExerciseGroups.isNotEmpty
        ? activeExerciseGroups.map((c) => ActiveExerciseGroup.fromMap(c)).toList()
        : [];
    return activeExerciseGroupList;
  }

  @override
  Future<List<ActiveExerciseGroup>> getActiveExerciseGroupsByWorkoutId(int workoutId) async {
    final Database db = await _dbHelper.database;
    var activeExerciseGroups = await db.query(
      'activeExerciseGroup',
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
    List<ActiveExerciseGroup> activeExerciseGroupList = activeExerciseGroups.isNotEmpty
        ? activeExerciseGroups.map((c) => ActiveExerciseGroup.fromMap(c)).toList()
        : [];
    return activeExerciseGroupList;
  }

  @override
  Future<int> deleteActiveExerciseGroup(int activeExerciseGroupId) async {
    final Database db = await _dbHelper.database;
    return await db.delete('activeExerciseGroup',
        where: 'activeExerciseGroupId = ?', whereArgs: [activeExerciseGroupId]);
  }

  @override
  Future<void> deleteActiveExerciseGroupsByWorkoutId(int workoutId) async {
    final Database db = await _dbHelper.database;
    List<Map<String, dynamic>> activeExerciseGroups = await db
        .query('activeExerciseGroup', where: 'workoutId = ?', whereArgs: [workoutId]);
    for (var activeExerciseGroup in activeExerciseGroups) {
      await deleteActiveExerciseGroup(activeExerciseGroup['activeExerciseGroupId']);
    }
  }

}
