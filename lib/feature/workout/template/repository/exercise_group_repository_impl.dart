import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'exercise_group_repository.dart';

class ExerciseGroupRepositoryImpl implements ExerciseGroupRepository {

  final DBHelper _dbHelper;

  ExerciseGroupRepositoryImpl(this._dbHelper);

  @override
  Future<int> addExerciseGroup(ExerciseGroup exerciseGroup) async {
    final Database db = await _dbHelper.database;
    return await db.insert(_dbHelper.EXERCISE_GROUP_TABLE, exerciseGroup.toMap());
  }

}