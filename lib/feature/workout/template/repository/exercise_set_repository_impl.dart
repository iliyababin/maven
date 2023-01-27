import 'package:Maven/common/model/exercise_set.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../common/util/database_helper.dart';
import 'exercise_set_repository.dart';

class ExerciseSetRepositoryImpl implements ExerciseSetRepository {

  final DBHelper _dbHelper;

  ExerciseSetRepositoryImpl(this._dbHelper);

  @override
  Future<int> addExerciseSet(ExerciseSet exerciseSet) async {
    final Database db = await _dbHelper.database;
    return await db.insert(_dbHelper.EXERCISE_SET_TABLE, exerciseSet.toMap());
  }
}